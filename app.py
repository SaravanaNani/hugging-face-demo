import gradio as gr
from transformers import pipeline

summarizer = pipeline("summarization")

def predict(text):
    return summarizer(text)[0]['summary_text']

demo = gr.Interface(fn=predict, inputs="textbox", outputs="textbox")
demo.launch()