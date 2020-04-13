package mail;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import data.dto.UserDto;

public class mailSend {
	public static void naverMailSend(UserDto dto) {

		String host = "smtp.naver.com"; 
		// ���̹��� ��� ���̹� ����, gmail��� gmail ���� 
		String user = "hwcho96@naver.com"; 
		// �н����� 
		String password = "password";
		// ���� �̸���
		String to_email = dto.getEmail();
		// SMTP ���� ������ �����Ѵ�. 
		Properties props = new Properties(); 
		props.put("mail.smtp.host", host); 
		props.put("mail.smtp.port", 465); 
		props.put("mail.smtp.auth", "true");
		
		//���� ��ȣ ������
        StringBuffer temp =new StringBuffer();
        Random rnd = new Random();
        for(int i=0;i<10;i++)
        {
            int rIndex = rnd.nextInt(3);
            switch (rIndex) {
            case 0:
                // a-z
                temp.append((char) ((int) (rnd.nextInt(26)) + 97));
                break;
            case 1:
                // A-Z
                temp.append((char) ((int) (rnd.nextInt(26)) + 65));
                break;
            case 2:
                // 0-9
                temp.append((rnd.nextInt(10)));
                break;
            }
        }
        String AuthenticationKey = temp.toString();
        System.out.println(AuthenticationKey);
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
			protected PasswordAuthentication getPasswordAuthentication() { 
				return new PasswordAuthentication(user, password); 
			} 
		}); 

		try { 
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email)); 
			// ���� ���� 
			message.setSubject("�ȳ��ϼ��� Questgram ���� �����Դϴ�"); 
			// ���� ���� 
			message.setText("���� ��ȣ: " + temp); 
			// send the message 
			Transport.send(message);
			System.out.println("Success Message Send"); 
		} catch (MessagingException e) {
			e.printStackTrace(); 
		} 
	}
}
