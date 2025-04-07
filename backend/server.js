const express = require('express');
const axios = require('axios');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

const GEMINI_API_URL = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

app.post('/predict', async (req, res) => {
    const { location, time, weather, event } = req.body;
  
    const prompt = `
      Location: ${location}
      Time: ${time}
      Weather: ${weather}
      Event: ${event}
  
      Task:
      - Predict traffic congestion level (Low, Medium, High).
      - Suggest two alternate routes with reasoning.
      - Explain why this area will have congestion.
  
      Format:
      {
        "congestion_level": "High",
        "reason": "Due to heavy rain and a local festival event at ${event}, traffic at ${location} around ${time} is expected to be heavy.",
        "alternate_routes": [
          "Route A: via XYZ Road (less busy)",
          "Route B: via ABC Marg (wider lanes)"
        ]
      }
    `;
  
    try {
      const response = await axios.post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?',
        {
          contents: [
            {
              parts: [{ text: prompt }],
            },
          ],
        },
        {
          headers: {
            'Content-Type': 'application/json',
            'x-goog-api-key': process.env.GEMINI_API_KEY,
          },
        }
      );
  
      const content = response.data.candidates[0].content.parts[0].text;
  
      try {
        const json = JSON.parse(content);
        res.json(json);
      } catch (err) {
        res.json({ raw: content, error: 'Parsing failed. Gemini may have returned invalid JSON.' });
      }
  
    } catch (err) {
      console.error('Gemini API error:', err);
      res.status(500).json({ error: 'Error calling Gemini API' });
    }
});
  

app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});
