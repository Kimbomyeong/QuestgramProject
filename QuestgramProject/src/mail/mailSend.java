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
		// 네이버일 경우 네이버 계정, gmail경우 gmail 계정 
		String user = "hwcho96@naver.com"; 
		// 패스워드 
		String password = "password";
		// 보낼 이메일
		String to_email = dto.getEmail();
		// SMTP 서버 정보를 설정한다. 
		Properties props = new Properties(); 
		props.put("mail.smtp.host", host); 
		props.put("mail.smtp.port", 465); 
		props.put("mail.smtp.auth", "true");
		
		//인증 번호 생성기
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
			// 메일 제목 
			message.setSubject("안녕하세요 Questgram 인증 메일입니다"); 
			// 메일 내용 
			message.setText("인증 번호: " + temp); 
			// send the message 
			Transport.send(message);
			System.out.println("Success Message Send"); 
		} catch (MessagingException e) {
			e.printStackTrace(); 
		} 
	}
}
