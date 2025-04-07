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

    Based on this, predict traffic congestion level and suggest 2 alternate routes with reasoning.
  `;

  try {
    const response = await axios.post(`${GEMINI_API_URL}?key=${process.env.GEMINI_API_KEY}`, {
      contents: [{
        parts: [{ text: prompt }]
      }]
    });

    const content = response.data.candidates[0].content.parts[0].text;

    res.json({ result: content });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Gemini API error' });
  }
});

app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});
