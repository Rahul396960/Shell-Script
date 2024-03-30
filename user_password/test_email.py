from irage_helper import send_mail

uemail="Rahul.sharma"
user="Test_user"
lowercase_word=user.lower()
password="123456"
send_mail("rahul.sharma@irage.in","Rahul Sharma",[f"{uemail}@irage.in"],"test email",f"Your new wifi and vpn(only if you use vpn) credential is: <br> username={lowercase_word} <br> password={password} <br><br> please let us kow if have any query. <br><br> Regards,<br>Rahul Sharma")
print(f"sending just for testing purpose<br> username={lowercase_word} <br> password= {password}")