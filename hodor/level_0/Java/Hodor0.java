/*
 * ===--------------------------------------------------------------------------===
 * 		Hodor Project Level 0, by Julien Barbier.
 * 		Solution using Java Programming language.
 *
 *		by Alexandro de Oliveira, for Holberton School.
 * ===--------------------------------------------------------------------------===
 */

import java.io.BufferedReader;
import java.io.OutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

public class Hodor0 {
	private static final String  P_URL = "http://173.246.108.142/level0.php";
	private final String USER_AGENT = "Havk64 Java http requests";
	public static void main(String[] args) throws Exception {
		Hodor0 http = new Hodor0();
		// Read the amount of votes from user:
		System.out.println("\nHow many votes? => ");
		Scanner reader = new Scanner(System.in);
		int total = reader.nextInt();
		// Calling the sendPost function "total" times:
		for(int i = 0; i < total; i++) {
			http.sendPost(i);
		}
	}
    // Function to set and send our POST request:
	private void sendPost(int n) throws Exception {
		URL obj = new URL(P_URL);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("POST");
		con.setRequestProperty("User-Agent", USER_AGENT);
		con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
		String urlParameters = "id=23&holdthedoor=submit";
		// Send the params body:
		con.setDoOutput(true);
		OutputStream wr = con.getOutputStream();
		// Parsing and optionally print the header:
		/*
		Map<String, List<String>> header = con.getHeaderFields();
		for (Map.Entry<String, List<String>> entry: header.entrySet()) {
			System.out.println(entry.getKey() + " => " + entry.getValue());
		}*/
		wr.write(urlParameters.getBytes());
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
