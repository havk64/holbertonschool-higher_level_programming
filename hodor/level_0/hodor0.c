#include <stdio.h> /* printf, sprintf */
#include <stdlib.h> /* exit */
#include <unistd.h> /* read, write, close */
#include <string.h> /* memcpy, memset */
#include <sys/socket.h> /* socket, connect */
#include <netinet/in.h> /* struct sockaddr_in, struct sockaddr */
#include <netdb.h> /* struct hostent, gethostbyname */


void error(const char *msg)
{
    perror(msg); exit(0);
}
/***
 *===---Description---------------------------------------------------------------===
 *  Solution for the Hodor Project, Level 0 by Julien Barbier.
 *  Using C Language! BOOOOMMMMMM ! ! !
 *  by Alexandro de Oliveira, for Holberton School
 *===-----------------------------------------------------------------------------===
 */
int main()
{
    /* Setting the http port, hostname and message */
    int portno =        80;
    char *host =        "173.246.108.142";
    char *message = "POST /level0.php HTTP/1.0\r\nContent-Type: application/x-www-form-urlencoded\r\nUser-Agent:C language POST Requests - Alexandro de Oliveira\r\nContent-Length:25\r\n\r\nid=23&holdthedoor=submit\r\n";

    struct hostent *server;
    struct sockaddr_in serv_addr;
    int sockfd, bytes, sent, received, total;
    char response[4096];

    /* create the socket */
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) error("ERROR opening socket");

    /* lookup the ip address */
    server = gethostbyname(host);
    if (server == NULL) error("ERROR, no such host");

    /* fill in the structure */
    memset(&serv_addr,0,sizeof(serv_addr));     /* Filling the sockarrd_in struct with '0's */
    serv_addr.sin_family = AF_INET;             /* Internet Protocol(IP) v4 addresses */
    serv_addr.sin_port = htons(portno);         /* TCP/IP port */
    memcpy(&serv_addr.sin_addr.s_addr,server->h_addr,server->h_length); /* Now we have the host address in the struct */

    /* connect the socket */
    if (connect(sockfd,(struct sockaddr *)&serv_addr,sizeof(serv_addr)) < 0)
        error("ERROR connecting");
/* send the request */
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

/* close the socket */
close(sockfd);

/* process response */
printf("Response:\n%s\n",response);

return 0;
}
