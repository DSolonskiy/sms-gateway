from flask_restx import fields
from server.instance import server

sms_post = server.api.model('Send SMS Payload', {
    'recipients': fields.List(
        fields.String,
        required=True,
        description='List of recipients',
        example=['+79210934181']
    ),
    'message': fields.String(
        required=True,
        max_length=480,
        description='Message to send',
        example='Hello, this my first sms'
    )
})

sms_send = server.api.model('Send SMS result', {
    'DestinationNumber': fields.String(
        example='+79210934181'
    ),
    'smsID': fields.Integer(
        example='1'
    ),
})

send_result = server.api.model('Send SMS results', {
    'results': fields.List(
        fields.Nested(sms_send),
        example=[
            {
                'DestinationNumber': '+79210934181',
                'smsID': '1'
            },
            {
                'DestinationNumber': '+79210934181',
                'smsID': '2'
            }
        ]

    )
}) 
