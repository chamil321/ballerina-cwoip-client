import ballerina/http;
import ballerina/log;

final string NAME = "NAME";
@http:ServiceConfig {
    basePath: "/chat"
}
service chatAppUpgrader on new http:Listener(9090) {
    @http:ResourceConfig {
        webSocketUpgrade: {
                upgradePath: "/{name}",
                upgradeService: chatApp
        }
    }
    resource function upgrader(http:Caller caller, http:Request req, string name) {
        http:WebSocketCaller wsEp;
        map<string> headers = {};
        wsEp = caller->acceptWebSocketUpgrade(headers);

        //wsEp.attributes[NAME] = name;
        string msg = "Hub: Aloha!\n";
        var err = wsEp->pushText(msg);
        if (err is error) {
            log:printError("Error sending message", err = err);
        }
    }
}

map<http:WebSocketCaller> connectionsMap = {};

service chatApp = @http:WebSocketServiceConfig {} service {
    resource function onOpen(http:WebSocketCaller caller) {
        string msg;
        msg = getAttributeStr(caller, NAME) + " connected to CWOIP server";
        log:printInfo(msg);
        //connectionsMap[caller.id] = caller;
    }

    resource function onText(http:WebSocketCaller caller, string text) {
        //broadcast(caller.id, text);
    }

    resource function onClose(http:WebSocketCaller caller, int statusCode,
                                string reason) {
        //_ = connectionsMap.remove(caller.id);
        string msg = getAttributeStr(caller, NAME) + " disconnected from CWOIP server";
    }
};

function broadcast(string callerId, string text) {
    //foreach var (id, con) in connectionsMap {
    //    if(id != callerId) {
    //        _ = start send(con, text);
    //    }
    //}
}

function send(http:WebSocketCaller con, string text) {
    var err = con->pushText(text);
    if (err is error) {
        log:printError("Error sending message", err = err);
    }
}

function getAttributeStr(http:WebSocketCaller ep, string key) returns (string) {
    //var name = <string>ep.attributes[key];
    return "";
}
