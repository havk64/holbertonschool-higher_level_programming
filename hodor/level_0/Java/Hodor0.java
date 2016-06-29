/*
 * ===--------------------------------------------------------------------------===
 * 		Hodor Project Level 0, by Julien Barbier.
 * 		Solution using Java Programming language.
 *
 *		by Alexandro de Oliveira, for Holberton School.
 * ===--------------------------------------------------------------------------===
 */

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

public class Hodor0 {
	private final String USER_AGENT = "Havk64 Java http requests";
	public static void main(String[] args) throws Exception {
		Hodor0 http = new Hodor0();
		System.out.println("\nStarting...");
		for(int i = 0; i < 1024; i++) {
			http.sendPost(i);
		}
	}
    // Function to set and send our POST request:
	private void sendPost(int n) throws Exception {
		String url = "http://173.246.108.142/level0.php";
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("POST");
		con.setRequestProperty("User-Agent", USER_AGENT);
		con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
		String urlParameters = "id=23&holdthedoor=submit";
		// Send the params body:
		con.setDoOutput(true);
		DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		wr.writeBytes(urlParameters);
		wr.flush();
		wr.close();
		int responseCode = con.getResponseCode();
		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
		System.out.println("Vote number: " + (n + 1));
		// Print the response body(html):
		// System.out.println(response.toString());

	}

}
