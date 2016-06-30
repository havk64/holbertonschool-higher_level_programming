/*
 * ===--------------------------------------------------------------------------===
 * 		Hodor Project Level 3, by Julien Barbier.
 * 		Solution using Scala Programming language + Tesseract-OCR.
 *      Using Scala version "2.11.8" + scalaj.http
 *
 *		by Alexandro de Oliveira, for Holberton School.
 * ===--------------------------------------------------------------------------===
 */

import scalaj.http._ //{HttpResponse, HttpOptions}
import scala.io.StdIn.readInt // for readInt
import java.io.FileWriter
import scala.sys.process._

object Hodor0 {
    def main(args: Array[String]) {
        // Get number from user:
        println("How many votes? => ")
        val total: Int = readInt()
        var count: Int = 0
        for(count <- 0 until total) {
            posting(count)
        }
    }
    def posting(n: Int): Unit = {
        val URL: String     = "http://173.246.108.142/level3.php"
        val CAPTCHA: String = "http://173.246.108.142/captcha.php"
        val AGENT: String   = "Windows NT 5.1 - Havk64 Scala requests"
        // Fetch the captcha:
        val getCaptcha: HttpResponse[String]= Http(CAPTCHA).asString
        val PHPCookie = getCaptcha.headers("Set-Cookie")(0).split(";")(0)
        println(PHPCookie)
        //val img = scala.io.Source.fromURL(CAPTCHA, "UTF-8").mkString
        val tmp = new FileWriter("tmp.png")
        tmp.write(getCaptcha.body)
        tmp.close
        var captcha: String = "tesseract tmp.png - 2> /dev/null" !!
        captcha = captcha.split(" ")(0) // Removing blank spaces.
        //println(captcha)
        // HEAD Request to fetch and parse fresh cookie:
        val head: HttpResponse[String] = Http(URL)
            .method("HEAD")
            .header("User-Agent", AGENT)
            .header("Cookie", PHPCookie )
            .option(HttpOptions.readTimeout(30000)) // To avoid timeout errors.
            .asString
        // Parsing the Cookie:
        var cookie: String = head.headers("Set-Cookie")(0).split(";")(0)
        val value: String = cookie.split("=")(1)
        // POST request:
        val response: HttpResponse[String] = Http(URL)
            .method("POST")
            .header("User-Agent", AGENT)
            .postForm(Seq("id" -> "23","holdthedoor" -> "submit", "key" -> value, "captcha" -> captcha))
            .header("Referer", URL)
            .header("Cookie", cookie + "; "+ PHPCookie)
            .option(HttpOptions.readTimeout(30000)).asString
        // Check if vote was computes:
        if(response.headers.contains("Set-Cookie")) {
            println(s"Vote number: ${n + 1}")
        } else {
            println("Failed...")
        }
        // Optionally print the Headers and Body.
        //println(response.headers)
        //println(response.body)
        */
    }
}
