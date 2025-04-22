package utils;



import java.io.IOException;
import java.util.List;

import org.springframework.core.io.ClassPathResource;

import com.google.auth.oauth2.GoogleCredentials;

public class FcmConfig {
	
	public static String getAccessToken() throws IOException{
		
		GoogleCredentials googleCredentials = GoogleCredentials
				.fromStream(new ClassPathResource("resource/service-account.json").getInputStream())
				.createScoped(List.of("https://www.googleapis.com/auth/firebase.messaging"));
		
		googleCredentials.refresh();
		return googleCredentials.getAccessToken().getTokenValue();
	}
}