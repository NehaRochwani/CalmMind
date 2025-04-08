from firebase_functions import https_fn
from firebase_admin import initialize_app
import google.generativeai as genai
import os

initialize_app()

@https_fn.on_request()
def get_gemini_response(req: https_fn.Request) -> https_fn.Response:
    # Set CORS headers to allow requests from your web app
    headers = {
        'Access-Control-Allow-Origin': '*',  # Adjust for production security
        'Access-Control-Allow-Methods': 'POST',
        'Access-Control-Allow-Headers': 'Content-Type'
    }

    if req.method != 'POST':
        return https_fn.Response("Method Not Allowed", status=405, headers=headers)

    if req.content_type != 'application/json':
        return https_fn.Response("Expected JSON payload", status=400, headers=headers)

    try:
        data = req.get_json()
        user_message = data.get('message')
        if not user_message:
            return https_fn.Response("Missing 'message' in request body", status=400, headers=headers)

        api_key = os.environ.get('FIREBASE_CONFIG').get('gemini', {}).get('api_key')
        if not api_key:
            print("Error: Gemini API key not configured in Firebase Functions.")
            return https_fn.Response("Gemini API key not configured", status=500, headers=headers)

        genai.configure(api_key=api_key)
        model = genai.GenerativeModel('gemini-1.5-flash')
        response = model.generate_content([user_message])
        gemini_response = response.text

        if gemini_response:
            return https_fn.Response({'response': gemini_response}, status=200, headers=headers)
        else:
            return https_fn.Response({'response': 'No response from Gemini.'}, status=200, headers=headers)

    except Exception as e:
        print(f"Error calling Gemini API: {e}")
        return https_fn.Response({'error': f'Error generating response from Gemini: {e}'}, status=500, headers=headers)