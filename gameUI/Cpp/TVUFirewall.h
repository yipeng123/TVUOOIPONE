
#ifndef  _TVUFirewall
#define  _TVUFirewall
//#include <string>
//#include <list>
using namespace std;
enum chn_status
{
ALLOW_ALL,
ALLOW_WHITE,
BLOCK_BLACK
};
extern "C"{
class TVUFirewall
{
public:
	bool addWhite(char* ip);
	bool addBlack(char* ip);
	bool removeWhite(char* ip); 
	bool removeBlack(char* ip);
	bool clearWhite();
	bool clearBlack();
	bool setChnnelStatus(enum chn_status status);
	bool allowIp(char* ip);
protected:
	enum chn_status m_channelStatus;
    
//	list<string> m_white;
//	list<string> m_black;
}; 
}
#endif
