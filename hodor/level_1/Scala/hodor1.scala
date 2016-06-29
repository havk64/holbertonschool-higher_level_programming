/*
 * ===--------------------------------------------------------------------------===
 * 		Hodor Project Level 1, by Julien Barbier.
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
        val URL: String = "http://173.246.108.142/level1.php"
        // HEAD Request to fetch and parse fresh cookie:
        val head: HttpResponse[String] = Http(URL)
            .method("HEAD")
            .option(HttpOptions.readTimeout(30000)) // To avoid timeout errors.
            .asString
        // Parsing the Cookie:
        var cookie: String = head.headers("Set-Cookie")(0).split(";")(0)
        val value: String = cookie.split("=")(1)
        // POST request:
        val response: HttpResponse[String] = Http(URL)
            .postForm(Seq("id" -> "23","holdthedoor" -> "submit", "key" -> value))
            .header("Content-Type", "application/x-www-form-urlencoded")
            .header("UserAgent", "Havk64 Scala requests")
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
