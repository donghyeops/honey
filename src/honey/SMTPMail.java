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
	private String fromAdress = "sjb378@naver.com";
	private String fromPassword = "qwerqwer";
	private Session session = null;
	private int joinNumber = 0;	// 회원가입 중 이메일 인증 시 생성되는 랜덤 수
	
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
        props.setProperty("mail.host", "smtp.naver.com"); 
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
    
	// 테스트용
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
    
    
    // 회원가입 메일 확인 숫자를 생성하고 메일로 보냄.
    public boolean sendJoinNumber(String toAddress) {
    	joinNumber = (int)(Math.random()*10000);
    	
    	try {
    		System.out.println(toAddress);
			sendMail(toAddress, "회원가입 확인", "회원가입 확인 숫자 : " + joinNumber);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
    	return true;
    }
    
    // 입력한 숫자와 메일 확인 숫자가 같은지 확인
    public boolean checkJoinNumber(int inputNumber) {
    	return joinNumber == inputNumber;
    }
}