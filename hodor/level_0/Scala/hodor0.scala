/*
 * ===--------------------------------------------------------------------------===
 * 		Hodor Project Level 0, by Julien Barbier.
 * 		Solution using Scala Programming language.
 *
 *		by Alexandro de Oliveira, for Holberton School.
 * ===--------------------------------------------------------------------------===
 */

import scalaj.http._
//import scala.io.StdIn.readInt // for readInt

object Hodor0 {
    def main(args: Array[String]) {
        // Get number from user:
        //println("How many votes? => ")
        //val total = readInt()
        var count: Int = 0
        for(count <- 0 until 1024) {
            posting(count)
        }
    }
    def posting(n: Int): Unit = {
        val response: HttpResponse[String] = Http("http://173.246.108.142/level0.php")
            .postForm(Seq("id" -> "23","holdthedoor" -> "submit"))
            .header("Content-Type", "application/x-www-form-urlencoded")
            .header("UserAgent", "Havk64 Scala requests")
            .option(HttpOptions.readTimeout(30000)).asString
        println(s"Vote number: ${n + 1}")
        //println(response.code)
        //println(response.headers)
        //println(response.body)
    }
}
