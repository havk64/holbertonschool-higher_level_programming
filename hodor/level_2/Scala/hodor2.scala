/*
 * ===--------------------------------------------------------------------------===
 * 		Hodor Project Level 2, by Julien Barbier.
 * 		Solution using Scala Programming language.
 *      Using Scala version "2.11.8" + scalaj.http
 *
 *		by Alexandro de Oliveira, for Holberton School.
 * ===--------------------------------------------------------------------------===
 */

import scalaj.http._ //{HttpResponse, HttpOptions}
import scala.io.StdIn.readInt // for readInt

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
        val URL: String = "http://173.246.108.142/level2.php"
        val AGENT: String = "Windows NT 5.1 - Havk64 Scala requests"
        // HEAD Request to fetch and parse fresh cookie:
        val head: HttpResponse[String] = Http(URL)
            .method("HEAD")
            .header("User-Agent", AGENT)
            .option(HttpOptions.readTimeout(30000)) // To avoid timeout errors.
            .asString
        // Parsing the Cookie:
        var cookie: String = head.headers("Set-Cookie")(0).split(";")(0)
        val value: String = cookie.split("=")(1)
        // POST request:
        val response: HttpResponse[String] = Http(URL)
            .method("POST")
            .header("User-Agent", AGENT)
            .postForm(Seq("id" -> "1","holdthedoor" -> "submit", "key" -> value))
            .header("Referer", URL)
            .header("Cookie", cookie)
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
    }
}
