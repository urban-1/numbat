#include <vector>

#ifndef FSM_H
#define FSM_H

#include <omnetpp.h>

class Fsm;
class FsmEvent;
class FsmState;

class FsmEvent
{
public:
    FsmEvent(int type, std::string name)
	:type(type), name(name) { };
    std::string fullName();
    int type;
    std::string name;
};

typedef int FsmStateType;
typedef int FsmEventType;

typedef FsmStateType onEventFunc(Fsm *fsm, FsmEventType e, cMessage *msg);
typedef FsmStateType onEnterFunc(Fsm *fsm);
typedef FsmStateType onExitFunc (Fsm *fsm);

class FsmState
{
public:
    bool inited;
    int type;
    std::string name;
    onEventFunc *onEvent;
    onEnterFunc *onEnter;
    onExitFunc  *onExit;
    Fsm * fsm;
};

class Fsm : public cSimpleModule {
protected:
    virtual void fsmInit() = 0;
    bool stateVerify();
    bool eventVerify();
    void statesEventsInit(int statesCnt, int eventsCnt);
    virtual void onEvent(FsmEventType e, cMessage *msg);
    virtual void stateInit(int type, std::string name, onEventFunc func); // stationary state
    virtual void stateInit(int type, std::string name, onEventFunc onEvent, onEnterFunc onEnter, onExitFunc onExit); // stationary state
    virtual void stateInit(int type, std::string name, int targetState, onEnterFunc onEnter, onExitFunc onExit); // transitive state
    void eventInit(int type, std::string name);

    std::vector<FsmState> States;
    std::vector<FsmEvent> Events;
    int StatesCnt;
    int EventsCnt;

    FsmStateType CurrentState;
};

class WMaxCtrlSSFsm : public Fsm
{

    void initialize();
    void handleMessage(cMessage *msg);

    // --- STATES ---
    typedef enum {
	STATE_INIT,
	STATE_WAIT_FOR_CDMA,
	STATE_SEND_CDMA,            // send CDMA code
	STATE_WAIT_ANON_RNG_RSP,    // wait for anonymous RNG-RSP
	SEND_RNG_REQ,               // send RNG-REQ
	WAIT_RNG_RSP,               // wait for RNG-RSP
	SEND_SBC_REQ,               // send SBC-REQ
	WAIT_SBC_RSP,               // wait for SBC-RSP

	/// @todo: PKM (TEKs)
	SEND_REG_REQ,               // send REG-REQ
	WAIT_REG_RSP,               // wait for REG-RSP

	// service flow creation
	INITIATE_SVC_FLOW_CREATION, // initialize service flow creation (i.e. start new FSMs for each flow)
	WAIT_FOR_SVC_FLOW_COMPLETE, // wait for service flow creation completion

	OPERATIONAL,                // network entry completed, service flows created, normal operation

	/// @todo - implement scanning

	// handover
	SEND_MSHO_REQ,              // send MSHO-REQ
	WAIT_BSHO_RSP,              // wait for BSHO-RSP
	SEND_HO_IND,                // send HO-IND
	HANDOVER_COMPLETE,          // handover complete
	
	STATE_NUM
    } State;

    // wait for CDMA opportunity state
    static FsmStateType onEventState_WaitForCdma(Fsm * fsm, FsmEventType s, cMessage *msg);

    // send CDMA code state
    static FsmStateType onEnterState_WaitAnonRngRsp(Fsm * fsm);
    static FsmStateType onExitState_WaitAnonRngRsp(Fsm * fsm);

    // wait for anonymous RNG-RSP state
    static FsmStateType onEventState_WaitForAnonRngRsp(Fsm * fsm, FsmEventType s, cMessage *msg);
    

    // --- EVENTS ---
    typedef enum {
	EVENT_CDMA_CODE,
	EVENT_NUM
    } Event;

    FsmStateType onEvent_CdmaCode(cMessage *msg);

};

#endif

