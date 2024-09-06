import os
import openai
import logging
import azure.functions as func
from azure.search.documents import SearchClient
from azure.search.documents.models import QueryType

# # GPT-4 API sleutel ophalen uit de omgevingsvariabelen
# openai.api_key = os.getenv("OPENAI_API_KEY")

# # Azure Search client configureren
# search_client = SearchClient(
#     endpoint=os.getenv("AZURE_SEARCH_ENDPOINT"),
#     index_name=os.getenv("AZURE_SEARCH_INDEX_NAME"),
#     credential=os.getenv("AZURE_SEARCH_API_KEY")
# )

# def call_gpt(prompt):
#     response = openai.ChatCompletion.create(
#         model="gpt-4",
#         messages=[
#             {"role": "system", "content": "You are an assistant."},
#             {"role": "user", "content": prompt}
#         ]
#     )
#     return response['choices'][0]['message']['content']

# def search_semantic(query):
#     results = search_client.search(
#         search_text=query,
#         query_type=QueryType.SEMANTIC,
#         semantic_configuration_name="default"
#     )
#     return [doc['content'] for doc in results]

async def main(req: func.HttpRequest) -> func.HttpResponse:
    try:
        # user_query = req.params.get('query')
        # if not user_query:
        #     return func.HttpResponse(
        #         "Please pass a query in the request.",
        #         status_code=400
        #     )

        # # Zoek resultaten met behulp van semantische zoekfunctie
        # search_results = search_semantic(user_query)

        # # Combineer resultaten in een prompt voor GPT-4
        # gpt_prompt = f"Answer the following based on these documents: {search_results}. Query: {user_query}"

        # # Gebruik GPT-4 om het antwoord te genereren
        # gpt_response = call_gpt(gpt_prompt)

        # return func.HttpResponse(gpt_response, status_code=200)
        return func.HttpResponse("ok", status_code=200)

    except Exception as e:
        logging.error(f"Error processing request: {str(e)}")
        return func.HttpResponse("Error processing the request", status_code=500)
