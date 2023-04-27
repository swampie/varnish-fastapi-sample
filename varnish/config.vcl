vcl 4.0;
import std;

backend default {
    .host = "web:8000";
}
sub vcl_recv {
    std.log("RECV: " + req.http.host + req.url);
    unset req.http.Cookie;
    set req.http.X-Varnish = 1;
    if (req.url ~ "testclear") {
        ban("req.http.host == knulst.de");
        return(synth(200, "Cache was cleared by Rest call"));
    }
}

sub vcl_backend_response {
  unset beresp.http.Cache-Control;
  set beresp.ttl = 3600s;
  set beresp.http.Cache-Control = "public";
}