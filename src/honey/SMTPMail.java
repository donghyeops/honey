package honey;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
 
public class SMTPMail {
	private static SMTPMail smtpMail = null;
	private String fromAdress = "sdh9446@gmail.com";
	private String fromPassword = "pczvmaqafuomelkr";
	private Session session = null;
	
	// 싱글톤 구현
	public static SMTPMail getInstance() {
		if (smtpMail == null) {
			smtpMail = new SMTPMail();
		}
		return smtpMail;
	}
	
	// 생성자에서 초기 설정해줌
    private SMTPMail() {
	    init();	// 초기 설정
    }
    
    private void init() {
        Properties props = new Properties(); 
        props.setProperty("mail.transport.protocol", "smtp"); 
        props.setProperty("mail.host", "smtp.gmail.com"); 
        props.put("mail.smtp.auth", "true"); 
        props.put("mail.smtp.port", "465"); 
        props.put("mail.smtp.socketFactory.port", "465"); 
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); 
        props.put("mail.smtp.socketFactory.fallback", "false"); 
        props.setProperty("mail.smtp.quitwait", "false"); 
         
        
        Authenticator auth = new Authenticator(){
            protected PasswordAuthentication getPasswordAuthentication() { 
                return new PasswordAuthentication(fromAdress, fromPassword); 
            }
        };
        session = Session.getDefaultInstance(props,auth);
    }
    
	private void sendMail(String toAddress, String subject, String content) throws Exception {
      Message message = new MimeMessage(session);
      message.setFrom(new InternetAddress(fromAdress));
      message.setRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));
      message.setSubject(subject);
      message.setContent(content, "text/html; charset=euc-kr");
       
      Transport.send(message);
    }
    
    public boolean sendHi() {
    	try {
			sendMail("ksw9446@naver.com", "sendHI", "하이");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
    	return true;
    }
}