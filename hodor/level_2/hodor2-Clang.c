
/***
 * ===---Description---------------------------------------------------------------===
 *   Solution for the Hodor Project, Level 2 by Julien Barbier.
 *   Using C Language!    BOOOOMMMMMM ! ! ! \o/ \o/ \o/
 *
 *  by Alexandro de Oliveira, for Holberton School
 * ===-----------------------------------------------------------------------------===
*/

#include <stdio.h>	/* printf, perror*/
#include <stdlib.h>	/* exit */
#include <unistd.h>	/* read, write, close */
#include <string.h>	/* memcpy, memset */
#include <sys/socket.h> /* socket, connect */
#include <netinet/in.h> /* struct sockaddr_in, struct sockaddr */
#include <netdb.h>	/* struct hostent, gethostbyname */
void vote();

void error(const char *msg)
{
    perror(msg); exit(0);
}

int main()
{
    int i;
    const int votes = 1 << 10; /* Using bitwise operation to get the 1024 votes. */
    i = 0;

    while(i < votes) {
        vote();
        printf("Vote numer: %d\n", i + 1);
        i++;
    }

    return 0;
}

void vote()
{
    /* Setting the http port, hostname and message */
    int portno 	     =	80;
    char * host      =	"173.246.108.142";
    char * message   =	"POST /level2.php HTTP/1.1\r\n"
			"Host:173.246.108.142\r\n"
			"Connection:close\r\n"
			"User-Agent:Windows NT 100000000.0.0.0.1 - (I'm kidding, I hate windows! Lol!)\r\n"
			"Referer:http://173.246.108.142/level2.php\r\n"
			"Cookie:HoldTheDoor=990aede99b2115451d612b8c50ae6332a8026b62\r\n"
			"Content-Length:69\r\nContent-Type: application/x-www-form-urlencoded\r\n"
			"\r\n"
			"id=23&holdthedoor=submit&key=990aede99b2115451d612b8c50ae6332a8026b62\r\n";

    struct hostent *server;
    struct sockaddr_in serv_addr;
    int sockfd, bytes, sent, received, total;
    char response[4096];

    /* Creating the socket */
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) error("ERROR opening socket");

    /* Lookup the IP address */
    server = gethostbyname(host);
    if (server == NULL) error("ERROR, no such host");

    /* Filling in the structure */
    memset(&serv_addr,0,sizeof(serv_addr));     /* Filling the sockarrd_in struct with '0's */
    serv_addr.sin_family = AF_INET;             /* Internet Protocol(IP) v4 addresses */
    serv_addr.sin_port = htons(portno);         /* TCP/IP port */
    memcpy(&serv_addr.sin_addr.s_addr,server -> h_addr,server -> h_length);
    /* Now we have the host address and all parameters set */

    /* Connecting the socket/starting the connection */
    if (connect(sockfd,(struct sockaddr *)&serv_addr,sizeof(serv_addr)) < 0)
	error("ERROR connecting");
    /* Sending the request */
    total = strlen(message);
    sent = 0;
    do {
        bytes = write(sockfd,message+sent,total-sent);
        if (bytes < 0)
	    error("ERROR writing message to socket");
        if (bytes == 0)
	    break;
        sent+=bytes;
    } while (sent < total);

    /* receive the response */
    memset(response,0,sizeof(response));
    total = sizeof(response)-1;
    received = 0;
    do {
        bytes = read(sockfd,response+received,total-received);
        if (bytes < 0)
	    error("ERROR reading response from socket");
        if (bytes == 0)
	    break;
        received+=bytes;
    } while (received < total);

    if (received == total)
	error("ERROR storing complete response from socket");

    /* Closing the socket */
    close(sockfd);

    /* Optionally, printing the response(the html body): */
    /* printf("Response:\n%s\n",response); */
}
