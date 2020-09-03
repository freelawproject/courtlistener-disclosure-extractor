from flask import Flask, jsonify, request
import disclosure_extractor

app = Flask(__name__)

#This contains a mini flask application that exposes an endpoint inside a
#docker container we used to process our financial documents.  The requirements
#of pillow are vulnerabilities so we need to use python3 which we are not currently
#supporting

@app.route("/")
def sanity_check():
    """ Sanity check. Curl container from insider CL to check if running
    Probably can get rid of this

    :return:
    """
    return "\nThe container is up running\n"


@app.route("/url", methods=["POST"])
def disclosure_url():
    """API Endpoint for sending and returning financial disclosures processed by our docker container

    :return:
    """
    try:
        c = request.get_json()
        r = disclosure_extractor.process_financial_document(url=c["url"])
        disclosure_extractor.print_results(r)
        return r
    except:
        return {"success": False, "msg": "Complete failure"}


app.run(host="0.0.0.0", port=5001)
