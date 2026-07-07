// Supabase Edge Function: gemini-vision
// Handles OCR (image-to-text) tasks for authenticated users.
//
// Deploy: supabase functions deploy gemini-vision

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { GoogleGenAI } from 'https://esm.sh/@google/genai'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) return unauthorized()

    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_ANON_KEY')!,
      { global: { headers: { Authorization: authHeader } } }
    )

    const { data: { user }, error: authError } = await supabase.auth.getUser()
    if (authError || !user) return unauthorized()

    // Expecting base64 image data and mimeType
    const { base64Image, mimeType } = await req.json()
    if (!base64Image || !mimeType) return badRequest('Missing base64Image or mimeType')

    const apiKey = Deno.env.get('GEMINI_API_KEY')
    if (!apiKey) return serverError('GEMINI_API_KEY secret is not set')

    const ai = new GoogleGenAI({ apiKey: apiKey, apiVersion: 'v1' })

    const prompt = 'Extract ALL text from this image exactly as it appears. This is a textbook or study material page. Return only the extracted text, preserving paragraph structure. Do not add any commentary or formatting beyond what is in the image.'

    const result = await ai.models.generateContent({
      model: 'gemini-3.1-flash-lite',
      contents: [
        { text: prompt },
        {
          inlineData: {
            data: base64Image,
            mimeType: mimeType
          }
        }
      ],
      config: { temperature: 0.2, maxOutputTokens: 4096 }
    })

    return new Response(JSON.stringify({ text: result.text || '' }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (error) {
    console.error('OCR Error:', error)
    return serverError(error instanceof Error ? error.message : 'Unknown error')
  }
})

function unauthorized() {
  return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } })
}

function badRequest(msg: string) {
  return new Response(JSON.stringify({ error: msg }), { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } })
}

function serverError(msg: string) {
  return new Response(JSON.stringify({ error: msg }), { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } })
}
