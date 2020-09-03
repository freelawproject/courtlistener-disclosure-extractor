from flask import Flask, jsonify, request
from disclosure_extractor import process_financial_document, print_results

app = Flask(__name__)


@app.route("/")
def sanity_check():
    """Sanity check

    :return: Successful response
    :type: dict
    """
    return {"success": True, "msg": "Docker container running."}


@app.route("/url", methods=["POST"])
def disclosure_url():
    """Disclosure Extractor for URLs

    API Endpoint for sending and returning financial disclosures
    processed by our docker container
    :return: financial_disclosure_data
    :type: dict
    """
    try:
        c = request.get_json()
        financial_disclosure_data = process_financial_document(url=c["url"])
        print_results(financial_disclosure_data)
        return financial_disclosure_data
    except:
        return {"success": False, "msg": "Complete failure"}


app.run(host="0.0.0.0", port=5001)
