import azure.functions
import logging
import sendgrid
import datetime
import psycopg2
import os
from config import BaseConfig as Config

def main(msg: azure.functions.ServiceBusMessage):
 message = msg.get_body().decode('utf-8')
 logging.info('Python ServiceBus queue trigger processed message: %s', message)
 connection = psycopg2.connect(dbname = Config.POSTGRES_DB, user = Config.POSTGRES_USER, password = Config.POSTGRES_PW, host = Config.POSTGRES_URL)
 cursor = connection.cursor()
 try:
  notification_id = int(message)
  notification_query = "SELECT subject, message FROM notification WHERE id={};".format(notification_id)
  cursor.execute(notification_query)
  notification_result = cursor.fetchone()
  subject_field = notification_result[0]
  body_field = notification_result[1]
  attendee_query = "SELECT email, first_name FROM attendee;"
  cursor.execute(attendee_query)
  attendees_result = cursor.fetchall()
  for email_field, first_name_field in attendees_result:
   content_field = "Hello {},\n\n{}".format(first_name_field, body_field)
   mail_object = sendgrid.helpers.mail.Mail(from_email = Config.ADMIN_EMAIL_ADDRESS, to_emails = email_field, subject = subject_field, plain_text_content = content_field)
   try:
    sendgrid_api = sendgrid.SendGridAPIClient(Config.SENDGRID_API_KEY)
    sendgrid_response = sendgrid_api.send(mail_object)
   except Exception as error:
    logging.error(error)
  n_attendees = len(attendees_result)
  status_field = "{} attendees were notified.".format(n_attendees)
  current_time = datetime.datetime.utcnow()
  update_command = "UPDATE notification SET status = '{}', completed_date = '{}' WHERE id = {};".format(status_field, current_time, notification_id)
  cursor.execute(update_command)
  connection.commit()
 except Exception as error:
  logging.error(error)
  connection.rollback()       
 finally:
  cursor.close()
  connection.close()
