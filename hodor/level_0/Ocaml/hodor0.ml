
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
         (* "X-GWT-Permutation", "0BB89375061712D90759336B50687E78");
         ("X-GWT-Module-Base", "http://www.google.com/flights/static/"); *)
         ("Referer", "http://173.246.108.142/level0.php");
         ("Content-Length", "23");
         ("Pragma", "no-cache");
         ("Cache-Control", "no-cache");
         ("data", "id=23&holdthedoor=submit";;

let search () = try (http_post "http://173.246.108.142/level1.php" post_para) with
    Http_client.Http_error (id, msg) -> msg;;

let _ = print_endline (search());;
