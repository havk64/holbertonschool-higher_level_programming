/*
 * ===---Description------------------------------------------------------------===
 *   Solution for the Hodor Project, Level 1 by Julien Barbier.
 *   Using Python script(httplib and urllib).
 *
 *   by Alexandro de Oliveira, for Holberton School
 * ===---Excecuting:-------------------------------------------------------------===
 *   To execute this script just run in the shell:
 *   $ php -f file
 *
 *   So cool!!!
 * ===---------------------------------------------------------------------------===
 */
// Starting...
<?php
$votes = (1 << 10);	// Total amount of desire votes.
$counter = 1;		// Initializing the counter.
$url = 'http://173.246.108.142/level0.php';
$data = array('id' => '1', 'holdthedoor' => 'submit');
$options = array(
    'http' => array(
        'header'  => "Content-type: application/x-www-form-urlencoded\r\n" .
                     "User-Agent: havk64 - PHP Requests\r\n",
        'method'  => 'POST',
        'content' => http_build_query($data)
    )
);

$context  = stream_context_create($options);
for ($i = 0; $i < $votes; $i++) {
        $result = file_get_contents($url, false, $context);
        if($result):
            echo "Vote number: ". $counter++ . "\n";
        else:
            echo "Connection error...(vote not computed)";
        endif;
}
?>
