//
//  TVUPackage.cpp
//  TestTvServer
//
//  Created by bug on 14-3-17.
//
//

#include "TVUPackage.h"
//#include "cocos2d.h"
//using namespace cocos2d;
#include <arpa/inet.h>

//TVU_INIT_TV_UDP,//tv信息
//TVU_TCP_REQUEST,//握手请求
//TVU_TCP_RESPONE,//握手响应
//TVU_MOUSE,//鼠标
//TVU_KEYBOARD,//android psp按键
//TVU_SENSOR,//传感器
//TVU_INPUT,//输入法
//TVU_INPUT_TEXT,//输入法有数据
//TVU_TOUCH,//触摸多点
//TVU_HEARTBEAT,//心跳
//TVU_PAY,//发起支付
//TVU_PAYREQUEST,//支付请求结果
//TVU_SERVER,
//TVU_GAME_INFO,//游戏下载信息
//TVU_DOWNLOAD,//游戏下载游戏列表
//TVU_KEYBEAN,
//TVU_KEYSTAUS,//红白机和街机的按钮显示
//TVU_IMG
TVUPackage::TVUPackage(int pkgType){
    l_namelist.clear();
    l_namelist.push_front(TVU_PACKAGE_MAPNAME_E);
    p_encodingType = TVU_ENCODING_JSON;
    switch (pkgType) {
        case TVU_INIT_TV_UDP:
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_TAG);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_VS);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_MINVS);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_WINH);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_WINW);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_NAME);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_SERVERPORT);
            break;
        case TVU_TCP_REQUEST:
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_TAG);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_VS);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_MINVS);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_CLINETPORT);
            break;

        case TVU_TCP_RESPONE:
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_TAG);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_RESPCODE);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_TEXT);

            break;
        case TVU_MOUSE:
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_ACT);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_X);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_Y);

            break;
        case TVU_KEYBOARD:
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_CODE);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_ACT);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_FLAG);

            break;
        case TVU_SENSOR:

            l_namelist.push_front(TVU_PACKAGE_MAPNAME_ACT);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_X);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_Y);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_Z);
            break;
        case TVU_INPUT:

            break;
        case TVU_INPUT_TEXT:

            l_namelist.push_front(TVU_PACKAGE_MAPNAME_TEXT);
            break;
        case TVU_TOUCH:
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_ACT);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_CNT);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_AID);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_AX);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_AY);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_BID);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_BX);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_BY);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_CID);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_CX);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_CY);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_FLAG);
            break;
        case TVU_HEARTBEAT:

            break;
        case TVU_PAY:
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_ACT);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_PID);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_PNAME);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_PRICE);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_PAYTYPE);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_PAYCID);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_APPID);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_CPID);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_CPORDERNUM);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_CPNAME);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_RESERVE);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_SIGN);

            break;
        case TVU_PAYREQUEST:
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_RESULTSTATE);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_RESULTCODE);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_RESULTSTRING);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_PID);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_PORDERNO);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_PNAME);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_SIGN);

            break;
        case TVU_SERVER:

            break;
        case TVU_GAME_INFO:
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_ACT);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_PKGNAME);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_GAMEINFO);

            break;
        case TVU_DOWNLOAD:
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_ACT);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_CODE);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_GAMEINFO);
            l_namelist.push_front(TVU_PACKAGE_MAPNAME_GAMEID);

            break;

        case TVU_KEYBEAN:

            break;
        case TVU_KEYSTAUS:

            break;
        case TVU_IMG:

            break;
        default:
            break;
    }
}

int TVUPackage::encode(unsigned char* buf,int bufLen){
    
    return 1;
}
TVUPackage* TVUPackage::decodeWithUdp(unsigned char* buf,int bufLen){
	if(buf[0]!='{'){
		return NULL;
	}
	int stack = 1;
			int jsonEnd = 1;
			for(;jsonEnd<bufLen;jsonEnd++)
			{
				if(buf[jsonEnd]=='}')
				{
					stack--;
					if(stack==0)
					{
						jsonEnd++;
						break;
					}
				}
				else if(buf[jsonEnd]=='{')
				{
					stack++;
				}
			}
			if(stack!=0)
			{
				return NULL;
			}
	buf[jsonEnd] = 0;
    TVUPackage* package =  new TVUPackage(TVU_INIT_TV_UDP);
    string json((const char*)buf);
    package->setData(json);
    return package;
}

TVUPackage* TVUPackage::decode(unsigned char* buf,int bufLen,int& remainLen,int& dataLen){
	TVUPackage * package = NULL;
		int jsonBegin = 0;
		for(;jsonBegin<bufLen;jsonBegin++)
		{
			if(buf[jsonBegin]=='{')
			{

				break;
			}
		}
		if(jsonBegin>=bufLen)
		{
			remainLen = 0;
			dataLen = 0;
			return package;
		}
		int stack = 1;
		int jsonEnd = jsonBegin+1;
		for(;jsonEnd<bufLen;jsonEnd++)
		{
			if(buf[jsonEnd]=='}')
			{
				stack--;
				if(stack==0)
				{
					break;
				}
			}
			else if(buf[jsonEnd]=='{')
			{
				stack++;
			}
		}
		if(stack==0)
		{
			dataLen = jsonEnd-jsonBegin+1;
			char * json = (char*)malloc(dataLen+1);
			memcpy(json,buf+jsonBegin,dataLen);
			json[dataLen] = 0;
			string strJson(json);
			free(json);
			    package =  new TVUPackage(TVU_INIT_TV_UDP);
			    package->setData(strJson);
				dataLen +=jsonBegin;
			remainLen = bufLen-dataLen;
		}
		else
		{
			dataLen = jsonBegin;
			remainLen = bufLen-jsonBegin;
		}
    return package;
}
int TVUPackage::setEncodingType(int type){
    
    return 0;
}
void TVUPackage::setPeerIP(char* ip){
//    p_peerIp = inet_addr(ip);
	in_addr addr;
	    inet_aton(ip, &addr);
	    setPeerIPWithInt(addr.s_addr);
//	    p_peerIp = addr.s_addr;
}


void TVUPackage::setPeerIPWithInt(unsigned int ip){
	p_peerIp = ip;
}

unsigned int TVUPackage::getPeerIp(){
    
    return p_peerIp;
}
void TVUPackage::setData(string json){
    Json::Reader reader;
	Json::Value  value;
	if(!reader.parse(json, value)){
//		LOGE("parse json = %s",json.c_str());
		return;
	}
    Json::Value::Members members(value.getMemberNames());

    for (Json::Value::Members::iterator it = members.begin(); it != members.end(); ++it)  {
        const std::string &key = *it;
        if(!key.compare(TVU_PACKAGE_MAPNAME_E)){
            addData(TVU_PACKAGE_MAPNAME_E, value[TVU_PACKAGE_MAPNAME_E].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_TAG)){
            addData(TVU_PACKAGE_MAPNAME_TAG, value[TVU_PACKAGE_MAPNAME_TAG].asString());
        }else if(!key.compare(TVU_PACKAGE_UDP_TYPE)){
            addData(TVU_PACKAGE_UDP_TYPE, value[TVU_PACKAGE_UDP_TYPE].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_VS)){
            addData(TVU_PACKAGE_MAPNAME_VS, value[TVU_PACKAGE_MAPNAME_VS].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_MINVS)){
            addData(TVU_PACKAGE_MAPNAME_MINVS, value[TVU_PACKAGE_MAPNAME_MINVS].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_WINW)){
            addData(TVU_PACKAGE_MAPNAME_WINW, value[TVU_PACKAGE_MAPNAME_WINW].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_WINH)){
            addData(TVU_PACKAGE_MAPNAME_WINH, value[TVU_PACKAGE_MAPNAME_WINH].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_NAME)){
            addData(TVU_PACKAGE_MAPNAME_NAME, value[TVU_PACKAGE_MAPNAME_NAME].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_MAC)){
            addData(TVU_PACKAGE_MAPNAME_MAC, value[TVU_PACKAGE_MAPNAME_MAC].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_SERVERPORT)){
            addData(TVU_PACKAGE_MAPNAME_SERVERPORT, value[TVU_PACKAGE_MAPNAME_SERVERPORT].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_UDPPORT)){
            addData(TVU_PACKAGE_MAPNAME_UDPPORT, value[TVU_PACKAGE_MAPNAME_UDPPORT].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_RESPCODE)){
            addData(TVU_PACKAGE_MAPNAME_RESPCODE, value[TVU_PACKAGE_MAPNAME_RESPCODE].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_TEXT)){
            addData(TVU_PACKAGE_MAPNAME_TEXT, value[TVU_PACKAGE_MAPNAME_TEXT].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_CLINETPORT)){
            addData(TVU_PACKAGE_MAPNAME_CLINETPORT, value[TVU_PACKAGE_MAPNAME_CLINETPORT].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_ACT)){
            addData(TVU_PACKAGE_MAPNAME_ACT, value[TVU_PACKAGE_MAPNAME_ACT].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_CODE)){
            addData(TVU_PACKAGE_MAPNAME_CODE, value[TVU_PACKAGE_MAPNAME_CODE].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_FLAG)){
            addData(TVU_PACKAGE_MAPNAME_FLAG, value[TVU_PACKAGE_MAPNAME_FLAG].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_X)){
            addData(TVU_PACKAGE_MAPNAME_X, value[TVU_PACKAGE_MAPNAME_X].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_Y)){
            addData(TVU_PACKAGE_MAPNAME_Y, value[TVU_PACKAGE_MAPNAME_Y].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_Z)){
            addData(TVU_PACKAGE_MAPNAME_Z, value[TVU_PACKAGE_MAPNAME_Z].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_CNT)){
            addData(TVU_PACKAGE_MAPNAME_CNT, value[TVU_PACKAGE_MAPNAME_CNT].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_AID)){
            addData(TVU_PACKAGE_MAPNAME_AID, value[TVU_PACKAGE_MAPNAME_AID].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_AX)){
            addData(TVU_PACKAGE_MAPNAME_AX, value[TVU_PACKAGE_MAPNAME_AX].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_AY)){
            addData(TVU_PACKAGE_MAPNAME_AY, value[TVU_PACKAGE_MAPNAME_AY].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_BID)){
            addData(TVU_PACKAGE_MAPNAME_BID, value[TVU_PACKAGE_MAPNAME_BID].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_BX)){
            addData(TVU_PACKAGE_MAPNAME_BX, value[TVU_PACKAGE_MAPNAME_BX].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_BY)){
            addData(TVU_PACKAGE_MAPNAME_BY, value[TVU_PACKAGE_MAPNAME_BY].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_CID)){
            addData(TVU_PACKAGE_MAPNAME_CID, value[TVU_PACKAGE_MAPNAME_CID].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_CX)){
            addData(TVU_PACKAGE_MAPNAME_CX, value[TVU_PACKAGE_MAPNAME_CX].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_CY)){
            addData(TVU_PACKAGE_MAPNAME_CY, value[TVU_PACKAGE_MAPNAME_CY].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_PID)){
            addData(TVU_PACKAGE_MAPNAME_PID, value[TVU_PACKAGE_MAPNAME_PID].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_PNAME)){
            addData(TVU_PACKAGE_MAPNAME_PNAME, value[TVU_PACKAGE_MAPNAME_PNAME].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_PRICE)){
            addData(TVU_PACKAGE_MAPNAME_PRICE, value[TVU_PACKAGE_MAPNAME_PRICE].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_DESC)){
            addData(TVU_PACKAGE_MAPNAME_DESC, value[TVU_PACKAGE_MAPNAME_DESC].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_PAYTYPE)){
            addData(TVU_PACKAGE_MAPNAME_PAYTYPE, value[TVU_PACKAGE_MAPNAME_PAYTYPE].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_PAYCID)){
            addData(TVU_PACKAGE_MAPNAME_PAYCID, value[TVU_PACKAGE_MAPNAME_PAYCID].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_APPID)){
            addData(TVU_PACKAGE_MAPNAME_APPID, value[TVU_PACKAGE_MAPNAME_APPID].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_CPID)){
            addData(TVU_PACKAGE_MAPNAME_CPID, value[TVU_PACKAGE_MAPNAME_CPID].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_CPORDERNUM)){
            addData(TVU_PACKAGE_MAPNAME_CPORDERNUM, value[TVU_PACKAGE_MAPNAME_CPORDERNUM].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_CPNAME)){
            addData(TVU_PACKAGE_MAPNAME_CPNAME, value[TVU_PACKAGE_MAPNAME_CPNAME].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_RESERVE)){
            addData(TVU_PACKAGE_MAPNAME_RESERVE, value[TVU_PACKAGE_MAPNAME_RESERVE].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_SIGN)){
            addData(TVU_PACKAGE_MAPNAME_SIGN, value[TVU_PACKAGE_MAPNAME_SIGN].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_RESULTSTATE)){
            addData(TVU_PACKAGE_MAPNAME_RESULTSTATE, value[TVU_PACKAGE_MAPNAME_RESULTSTATE].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_RESULTCODE)){
            addData(TVU_PACKAGE_MAPNAME_RESULTCODE, value[TVU_PACKAGE_MAPNAME_RESULTCODE].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_RESULTSTRING)){
            addData(TVU_PACKAGE_MAPNAME_RESULTSTRING, value[TVU_PACKAGE_MAPNAME_RESULTSTRING].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_PORDERNO)){
            addData(TVU_PACKAGE_MAPNAME_PORDERNO, value[TVU_PACKAGE_MAPNAME_PORDERNO].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_PKGNAME)){
            addData(TVU_PACKAGE_MAPNAME_PKGNAME, value[TVU_PACKAGE_MAPNAME_PKGNAME].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_GAMEINFO)){
            addData(TVU_PACKAGE_MAPNAME_GAMEINFO, value[TVU_PACKAGE_MAPNAME_GAMEINFO].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_GAMEID)){
            addData(TVU_PACKAGE_MAPNAME_GAMEID, value[TVU_PACKAGE_MAPNAME_GAMEID].asString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_GAMETYPE)){
            addData(TVU_PACKAGE_MAPNAME_GAMETYPE, value[TVU_PACKAGE_MAPNAME_GAMETYPE].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_ISMAINCONTRAL)){
            addData(TVU_PACKAGE_MAPNAME_ISMAINCONTRAL, value[TVU_PACKAGE_MAPNAME_ISMAINCONTRAL].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_INPUTFLAG)){
            addData(TVU_PACKAGE_MAPNAME_INPUTFLAG, value[TVU_PACKAGE_MAPNAME_INPUTFLAG].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_ISROOTED)){
            addData(TVU_PACKAGE_MAPNAME_ISROOTED, value[TVU_PACKAGE_MAPNAME_ISROOTED].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_CAPABILITY)){
            addData(TVU_PACKAGE_MAPNAME_CAPABILITY, value[TVU_PACKAGE_MAPNAME_CAPABILITY].toStyledString());
        }else if(!key.compare(TVU_PACKAGE_MAPNAME_NESCONTRAL)){
            addData(TVU_PACKAGE_MAPNAME_NESCONTRAL, value[TVU_PACKAGE_MAPNAME_NESCONTRAL].toStyledString());
        }
    }
}

string TVUPackage::toJson(){
    string json = "{";
    for (map<string, string>::iterator it = m_map.begin(); it!=m_map.end(); it++) {
        string name = it->first;
        string value = it->second;
        json = json+"\""+name+"\":";
        bool isInNames = false;
        for (int i = 0; i<sizeof(STRINGNames)/sizeof(STRINGNames[0]); i++) {
            if (!name.compare(STRINGNames[i])) {
                isInNames = true;
                break;
            }
        }
        if (isInNames&&name.compare(TVU_PACKAGE_MAPNAME_GAMEINFO)) {
            json = json+"\""+value+"\"";
        }else{
            json = json+value;
        }
        json = json+",";
    }
    json = string(json,0,strlen(json.c_str())-1);
    json = json+"}";
//    CCLog("");
    return json;
}
void TVUPackage::addData(string name, string value){
	m_map.insert(map<string, string>::value_type(name,value));

}

void TVUPackage::removeData(string name){
    m_map.erase(name);
}

string TVUPackage::getDataWithName(string name){
    if (!m_map.empty()) {
        map<string, string>::iterator it;
        it =m_map.find(name);
        if (it==m_map.end()) {
            return "";
        }else{
           return it->second;
        }
    }else{
        return "";
    }
}

