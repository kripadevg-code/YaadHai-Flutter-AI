// Supabase Edge Function: gemini-generate
// Handles all text-based Gemini AI tasks for authenticated users.
// The GEMINI_API_KEY lives ONLY in Supabase Secrets — never in the Flutter app.
//
// Deploy: supabase functions deploy gemini-generate
// Secret:  supabase secrets set GEMINI_API_KEY=your_key_here

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { GoogleGenAI } from 'https://esm.sh/@google/genai'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const textGenConfig = {
  temperature: 0.3,
  topK: 40,
  topP: 0.95,
  maxOutputTokens: 8192,
  response_mime_type: 'application/json',
}

Deno.serve(async (req: Request) => {
  // CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // ── 1. Authenticate user via JWT ──────────────────────────────────────────
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) return unauthorized()

    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_ANON_KEY')!,
      { global: { headers: { Authorization: authHeader } } }
    )

    const { data: { user }, error: authError } = await supabase.auth.getUser()
    if (authError || !user) return unauthorized()

    // ── 2. Parse Request Body ─────────────────────────────────────────────────
    const { action, text, chapterTitle, flashcardCount, quizCount, conceptTitle } = await req.json()
    if (!action) return badRequest('Missing action')

    // ── 3. Initialize Gemini ──────────────────────────────────────────────────
    const apiKey = Deno.env.get('GEMINI_API_KEY')
    if (!apiKey) return serverError('GEMINI_API_KEY secret is not set')

    const ai = new GoogleGenAI({ apiKey: apiKey, apiVersion: 'v1' })

    // ── 4. Route Actions ──────────────────────────────────────────────────────
    let prompt = ''

    if (action === 'generateStudyPack') {
      if (!text || !chapterTitle) return badRequest('Missing text or chapterTitle')
      const fCount = flashcardCount || 8
      const qCount = quizCount || 5
      prompt = `
      You are a learning assistant. Extract exactly ${fCount} key points and ${fCount} core concepts from the provided text.
      Also create ${fCount} flashcards and ${qCount} quiz questions.

      TEXT: ${text}
      CHAPTER TITLE: ${chapterTitle}

      OUTPUT JSON:
      {
        "summary": "String",
        "keyPoints": ["String"],
        "concepts": [
          {
            "title": "String",
            "summary": "String",
            "explanation": "String",
            "keyPoints": ["String"],
            "isInterviewRelevant": boolean,
            "importanceScore": 1-10
          }
        ],
        "flashcards": [
          { "question": "String", "answer": "String", "hint": "String" }
        ],
        "quiz": [
          {
            "question": "String",
            "optionA": "String",
            "optionB": "String",
            "optionC": "String",
            "optionD": "String",
            "correctOption": "A, B, C, or D",
            "explanation": "String"
          }
        ]
      }
      Return ONLY valid JSON.
      `
    } else if (action === 'generateFlashcards') {
      if (!text) return badRequest('Missing text')
      const count = flashcardCount || 8
      prompt = `
      Create exactly ${count} flashcards from this text.
      Text: ${text}
      OUTPUT JSON: [{ "question": "String", "answer": "String", "hint": "String (Optional)" }]
      Return ONLY valid JSON.
      `
    } else if (action === 'generateQuiz') {
      if (!text) return badRequest('Missing text')
      const count = quizCount || 5
      prompt = `
      Create exactly ${count} multiple choice questions from this text.
      Text: ${text}
      OUTPUT JSON: [
        {
          "question": "String",
          "optionA": "String",
          "optionB": "String",
          "optionC": "String",
          "optionD": "String",
          "correctOption": "A, B, C, or D",
          "explanation": "String"
        }
      ]
      Return ONLY valid JSON.
      `
    } else if (action === 'explainConcept') {
      if (!conceptTitle || !text) return badRequest('Missing conceptTitle or text context')
      prompt = `
      You are a friendly tutor. Explain the concept "${conceptTitle}" using simple analogies.
      Use this text as context: ${text}
      Format: Plain text with bullet points if necessary. Do not return JSON.
      `
      
      const result = await ai.models.generateContent({
        model: 'gemini-3.1-flash-lite',
        contents: prompt,
        config: { temperature: 0.3, maxOutputTokens: 8192 }
      })
      
      return new Response(JSON.stringify({ text: result.text }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    } else {
      return badRequest(`Unknown action: ${action}`)
    }

    // ── 5. Execute Gemini Generation ──────────────────────────────────────────
    const result = await ai.models.generateContent({
      model: 'gemini-3.1-flash-lite',
      contents: prompt,
      config: textGenConfig
    })
    const rawText = result.text || ''

    // Clean JSON markdown if model accidentally included it
    let cleanText = rawText.trim()
    if (cleanText.startsWith('```json')) cleanText = cleanText.substring(7)
    else if (cleanText.startsWith('```')) cleanText = cleanText.substring(3)
    if (cleanText.endsWith('```')) cleanText = cleanText.substring(0, cleanText.length - 3)

    return new Response(cleanText.trim(), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (error) {
    console.error('Edge function error:', error)
    return serverError(error instanceof Error ? error.message : 'Unknown error')
  }
})

// ── Helpers ───────────────────────────────────────────────────────────────────

function unauthorized() {
  return new Response(JSON.stringify({ error: 'Unauthorized' }), {
    status: 401,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  })
}

function badRequest(msg: string) {
  return new Response(JSON.stringify({ error: msg }), {
    status: 400,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  })
}

function serverError(msg: string) {
  return new Response(JSON.stringify({ error: msg }), {
    status: 500,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  })
}
