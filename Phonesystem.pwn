=============================================
        DEEMASXI
    COPAS FROM : LUPA
=============================================
SEARCH: new Text:TimeTD;
// CallingTD
new Text:CallingTD[13];
new PlayerText:CallingPlayerTD[MAX_PLAYERS][5];
new Text:CloseCallTD;
new Text:PICKUP;
new Text:HANGUP;
// PHONE TEXTDRAWS
new Text:PhoneTD[20];
new Text:phoneclosetd;
new Text:mesaagetd;
new Text:contactstd;
new Text:calltd;
new Text:twittertd;
new Text:banktd;
new Text:musictd;
// Twitter App
new Text:TwitterApp[22];
new Text:addtexttd;
// PHONE TRANSFER
new Text:PhoneAtmTD[7];
new PlayerText:PhoneAtmPlayer[MAX_PLAYERS];
new Text:PhoneAtmExit;
new Text:PhoneAtmTransfer;

new gListedItems[MAX_PLAYERS][100], gTargetName[MAX_PLAYERS][MAX_PLAYER_NAME];

//ATM TEXTDRAWS
new Text:ATMTD[7];
new PlayerText:SHOWID[MAX_PLAYERS][16];
new Text:withdrawtd;
new Text:deposittd;
new Text:transfertd;
new PlayerText:ATMTD2[MAX_PLAYERS][2];
=============================================
SEARCH: pGasCan,
pPhoneSMS,
 pCallTimer,
	pCalling,
=============================================
SEARCH:  RefreshTime()
     format(string, sizeof(string), "%02d:%02d", hour, minute);
	TextDrawSetString(PhoneTD[11], string);

    format(string, sizeof(string), "%02d:%02d", hour, minute);
	TextDrawSetString(CallingTD[11], string);
==============================================
SEARCH: Object_Nearest(playerid)
public OnPlayerClickTextDraw(playerid, Text:clickedid) {
    // ATM TEXTDRAWS
	if(clickedid == withdrawtd	) {
		ShowDialogToPlayer(playerid, DIALOG_ATMWITHDRAW);
	}
	if(clickedid == deposittd) {
 		ShowDialogToPlayer(playerid, DIALOG_ATMDEPOSIT);
	}
	if(clickedid == transfertd) {
		ShowDialogToPlayer(playerid, DIALOG_ATM_TRANSFER);
	}
	// PHONE  TEXTDRAWS
	if(clickedid == calltd) {
		ShowPlayerDialog(playerid, DIALOG_PHONE_CALL, DIALOG_STYLE_INPUT, "{6688FF}Call Number", "Please specify the number you would like to call:", "Call", "Cancel");
	}
	if(clickedid == mesaagetd) {
		ShowPlayerDialog(playerid, DIALOG_PHONE_SMS, DIALOG_STYLE_INPUT, "{6688FF}SMS Number", "Please specify the number you would like to SMS:", "Sms", "Cancel");
	}
	if(clickedid == banktd) {
 		for(new i = 0; i < 5; i++) {
			TextDrawShowForPlayer(playerid, PhoneAtmTD[i]);
		}
		PlayerTextDrawShow(playerid, PhoneAtmPlayer[playerid]);
		TextDrawShowForPlayer(playerid, PhoneAtmTransfer);
		TextDrawShowForPlayer(playerid, PhoneAtmExit);
		SelectTextDraw(playerid, COLOR_LIGHTBLUE);
	}
	if(clickedid == contactstd) {
		ListContacts(playerid);
	}
	if(clickedid == addtexttd) {
		ShowPlayerDialog(playerid, DIALOG_TWEET, DIALOG_STYLE_INPUT, "Tweet", "What's on your mind?", "Post", "Back");
	}
	if(clickedid == twittertd) {
		for(new i = 0; i < 20; i++) {
			TextDrawHideForPlayer(playerid, PhoneTD[i]);
		}
   		TextDrawHideForPlayer(playerid, phoneclosetd);
		TextDrawHideForPlayer(playerid, banktd);
		TextDrawHideForPlayer(playerid, mesaagetd);
		TextDrawHideForPlayer(playerid, calltd);
		TextDrawHideForPlayer(playerid, contactstd);
		TextDrawHideForPlayer(playerid, musictd);
		TextDrawHideForPlayer(playerid, twittertd);
 		for(new i = 0; i < 22; i++) {
			TextDrawShowForPlayer(playerid, TwitterApp[i]);
		}
		TextDrawShowForPlayer(playerid, TwitterApp[0]);
		TextDrawShowForPlayer(playerid, TwitterApp[1]);
		TextDrawShowForPlayer(playerid, phoneclosetd);
		TextDrawShowForPlayer(playerid, addtexttd);

		SelectTextDraw(playerid, COLOR_LIGHTBLUE);
	}
	if(clickedid == musictd) {
		PlayerInfo[playerid][pMusicType] = MUSIC_MP3PLAYER;
		ShowDialogToPlayer(playerid, DIALOG_MP3PLAYER);
	}
	if(clickedid == phoneclosetd) {
 		for(new i = 0; i < 20; i++) {
			TextDrawHideForPlayer(playerid, PhoneTD[i]);
		}
 		for(new i = 0; i < 22; i++) {
			TextDrawHideForPlayer(playerid, TwitterApp[i]);
		}
		TextDrawHideForPlayer(playerid, TwitterApp[0]);
		TextDrawHideForPlayer(playerid, TwitterApp[1]);
		TextDrawHideForPlayer(playerid, phoneclosetd);
		TextDrawHideForPlayer(playerid, addtexttd);
		TextDrawHideForPlayer(playerid, banktd);
		TextDrawHideForPlayer(playerid, mesaagetd);
		TextDrawHideForPlayer(playerid, calltd);
		TextDrawHideForPlayer(playerid, contactstd);
		TextDrawHideForPlayer(playerid, phoneclosetd);
		TextDrawHideForPlayer(playerid, musictd);
		TextDrawHideForPlayer(playerid, twittertd);
		CancelSelectTextDraw(playerid);
	}
	// PHONE ATMTD
	if(clickedid == PhoneAtmTransfer) {
		ShowDialogToPlayer(playerid, DIALOG_ATM_TRANSFER);
	}
	if(clickedid == PhoneAtmExit) {
 		for(new i = 0; i < 5; i++) {
			TextDrawHideForPlayer(playerid, PhoneAtmTD[i]);
		}

		PlayerTextDrawHide(playerid, PhoneAtmPlayer[playerid]);
		TextDrawHideForPlayer(playerid, PhoneAtmTransfer);
		TextDrawHideForPlayer(playerid, PhoneAtmExit);
		SelectTextDraw(playerid, COLOR_LIGHTBLUE);
	}
	// CALLING TD
	if(clickedid == PICKUP) {
	    if(PlayerInfo[playerid][pTazedTime] > 0 || PlayerInfo[playerid][pInjured] > 0 || PlayerInfo[playerid][pHospital] > 0 || PlayerInfo[playerid][pTied] > 0 || PlayerInfo[playerid][pCuffed] > 0 || PlayerInfo[playerid][pJailTime] > 0)
		{
		    return SCM(playerid, COLOR_SYNTAX, "You are unable to use your cellphone at the moment.");
		}

		SendProximityMessage(playerid, 20.0, SERVER_COLOR, "**{C2A2DA} %s presses a button and answers their mobile phone.", GetRPName(playerid));
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);

		PlayerInfo[PlayerInfo[playerid][pCallLine]][pCallStage] = 2;
		PlayerInfo[playerid][pCallStage] = 2;
		PlayerTextDrawHide(playerid, CallingPlayerTD[playerid][3]);
		PlayerTextDrawHide(PlayerInfo[playerid][pCallLine], CallingPlayerTD[playerid][4]);
		TextDrawHideForPlayer(playerid, PICKUP);
		//TextDrawHideForPlayer(playerid, HANGUP);
		SCM(playerid, COLOR_WHITE, "** You have answered the call. You can now speak in chat to talk to the caller.");
		SCM(PlayerInfo[playerid][pCallLine], COLOR_WHITE, "** They answered the call. You can now speak in chat to talk to them.");
	}
	if(clickedid == HANGUP) {
		for(new i = 0; i < 13; i ++)
		{
			TextDrawHideForPlayer(playerid, CallingTD[i]);
		}
		for(new g = 0; g < 5; g++) {
			PlayerTextDrawHide(playerid, CallingPlayerTD[playerid][g]);
		}
		TextDrawHideForPlayer(playerid, CloseCallTD);
		TextDrawHideForPlayer(playerid, PICKUP);
		TextDrawHideForPlayer(playerid, HANGUP);
		HangupCall(playerid, HANGUP_USER);
		CancelSelectTextDraw(playerid);
	}
	if(clickedid == CloseCallTD) {
		for(new i = 0; i < 13; i ++)
		{
			TextDrawHideForPlayer(playerid, CallingTD[i]);
		}
		for(new g = 0; g < 5; g++) {
			PlayerTextDrawHide(playerid, CallingPlayerTD[playerid][g]);
		}
		TextDrawHideForPlayer(playerid, CloseCallTD);
		TextDrawHideForPlayer(playerid, PICKUP);
		TextDrawHideForPlayer(playerid, HANGUP);
		CancelSelectTextDraw(playerid);
	}
 	if(clickedid == Text:INVALID_TEXT_DRAW && !PlayerInfo[playerid][pLogged])
	{
		SelectTextDraw(playerid, COLOR_LIGHTBLUE);
	}
	return 1;
}
========================================================
SEARCH: // Blindfold or ANN[2]
// Calling Textdraws
	CallingTD[0] = TextDrawCreate(375.000000, 170.000000, "ld_pool:ball");
	TextDrawFont(CallingTD[0], 4);
	TextDrawLetterSize(CallingTD[0], 0.600000, 2.000000);
	TextDrawTextSize(CallingTD[0], 17.000000, 17.000000);
	TextDrawSetOutline(CallingTD[0], 1);
	TextDrawSetShadow(CallingTD[0], 0);
	TextDrawAlignment(CallingTD[0], 1);
	TextDrawColor(CallingTD[0], 255);
	TextDrawBackgroundColor(CallingTD[0], 255);
	TextDrawBoxColor(CallingTD[0], 50);
	TextDrawUseBox(CallingTD[0], 1);
	TextDrawSetProportional(CallingTD[0], 1);
	TextDrawSetSelectable(CallingTD[0], 0);

	CallingTD[1] = TextDrawCreate(478.000000, 171.000000, "ld_pool:ball");
	TextDrawFont(CallingTD[1], 4);
	TextDrawLetterSize(CallingTD[1], 0.600000, 2.000000);
	TextDrawTextSize(CallingTD[1], 17.000000, 17.000000);
	TextDrawSetOutline(CallingTD[1], 1);
	TextDrawSetShadow(CallingTD[1], 0);
	TextDrawAlignment(CallingTD[1], 1);
	TextDrawColor(CallingTD[1], 255);
	TextDrawBackgroundColor(CallingTD[1], 255);
	TextDrawBoxColor(CallingTD[1], 50);
	TextDrawUseBox(CallingTD[1], 1);
	TextDrawSetProportional(CallingTD[1], 1);
	TextDrawSetSelectable(CallingTD[1], 0);

	CallingTD[2] = TextDrawCreate(435.000000, 178.000000, "_");
	TextDrawFont(CallingTD[2], 1);
	TextDrawLetterSize(CallingTD[2], 0.600000, 26.300064);
	TextDrawTextSize(CallingTD[2], 298.500000, 115.500000);
	TextDrawSetOutline(CallingTD[2], 1);
	TextDrawSetShadow(CallingTD[2], 0);
	TextDrawAlignment(CallingTD[2], 2);
	TextDrawColor(CallingTD[2], -1);
	TextDrawBackgroundColor(CallingTD[2], 255);
	TextDrawBoxColor(CallingTD[2], 255);
	TextDrawUseBox(CallingTD[2], 1);
	TextDrawSetProportional(CallingTD[2], 1);
	TextDrawSetSelectable(CallingTD[2], 0);

	CallingTD[3] = TextDrawCreate(435.000000, 173.000000, "_");
	TextDrawFont(CallingTD[3], 1);
	TextDrawLetterSize(CallingTD[3], 0.600000, 27.450054);
	TextDrawTextSize(CallingTD[3], 298.500000, 104.500000);
	TextDrawSetOutline(CallingTD[3], 1);
	TextDrawSetShadow(CallingTD[3], 0);
	TextDrawAlignment(CallingTD[3], 2);
	TextDrawColor(CallingTD[3], -1);
	TextDrawBackgroundColor(CallingTD[3], 255);
	TextDrawBoxColor(CallingTD[3], 255);
	TextDrawUseBox(CallingTD[3], 1);
	TextDrawSetProportional(CallingTD[3], 1);
	TextDrawSetSelectable(CallingTD[3], 0);

	CallingTD[4] = TextDrawCreate(435.000000, 188.000000, "_");
	TextDrawFont(CallingTD[4], 1);
	TextDrawLetterSize(CallingTD[4], 0.433333, 23.150011);
	TextDrawTextSize(CallingTD[4], 298.500000, 111.500000);
	TextDrawSetOutline(CallingTD[4], 1);
	TextDrawSetShadow(CallingTD[4], 0);
	TextDrawAlignment(CallingTD[4], 2);
	TextDrawColor(CallingTD[4], -1);
	TextDrawBackgroundColor(CallingTD[4], 255);
	TextDrawBoxColor(CallingTD[4], -1061109625);
	TextDrawUseBox(CallingTD[4], 1);
	TextDrawSetProportional(CallingTD[4], 1);
	TextDrawSetSelectable(CallingTD[4], 0);

	CallingTD[5] = TextDrawCreate(377.000000, 187.000000, "ld_bum:bum2");
	TextDrawFont(CallingTD[5], 4);
	TextDrawLetterSize(CallingTD[5], 0.600000, 2.000000);
	TextDrawTextSize(CallingTD[5], 115.500000, 189.000000);
	TextDrawSetOutline(CallingTD[5], 1);
	TextDrawSetShadow(CallingTD[5], 0);
	TextDrawAlignment(CallingTD[5], 1);
	TextDrawColor(CallingTD[5], 255);
	TextDrawBackgroundColor(CallingTD[5], 255);
	TextDrawBoxColor(CallingTD[5], 50);
	TextDrawUseBox(CallingTD[5], 1);
	TextDrawSetProportional(CallingTD[5], 1);
	TextDrawSetSelectable(CallingTD[5], 0);

	CallingTD[6] = TextDrawCreate(408.000000, 175.000000, "PHLRP PHONE");
	TextDrawFont(CallingTD[6], 1);
	TextDrawLetterSize(CallingTD[6], 0.258332, 0.699998);
	TextDrawTextSize(CallingTD[6], 611.000000, -194.500000);
	TextDrawSetOutline(CallingTD[6], 1);
	TextDrawSetShadow(CallingTD[6], 0);
	TextDrawAlignment(CallingTD[6], 1);
	TextDrawColor(CallingTD[6], -1);
	TextDrawBackgroundColor(CallingTD[6], 255);
	TextDrawBoxColor(CallingTD[6], 50);
	TextDrawUseBox(CallingTD[6], 0);
	TextDrawSetProportional(CallingTD[6], 1);
	TextDrawSetSelectable(CallingTD[6], 0);

	CallingTD[7] = TextDrawCreate(480.000000, 176.000000, "ld_pool:ball");
	TextDrawFont(CallingTD[7], 4);
	TextDrawLetterSize(CallingTD[7], 0.600000, 2.000000);
	TextDrawTextSize(CallingTD[7], 4.000000, 5.500000);
	TextDrawSetOutline(CallingTD[7], 1);
	TextDrawSetShadow(CallingTD[7], 0);
	TextDrawAlignment(CallingTD[7], 1);
	TextDrawColor(CallingTD[7], 1296911871);
	TextDrawBackgroundColor(CallingTD[7], 255);
	TextDrawBoxColor(CallingTD[7], 1296911666);
	TextDrawUseBox(CallingTD[7], 1);
	TextDrawSetProportional(CallingTD[7], 1);
	TextDrawSetSelectable(CallingTD[7], 0);

	CallingTD[8] = TextDrawCreate(376.000000, 413.000000, "ld_pool:ball");
	TextDrawFont(CallingTD[8], 4);
	TextDrawLetterSize(CallingTD[8], 0.600000, 2.000000);
	TextDrawTextSize(CallingTD[8], 10.000000, 10.000000);
	TextDrawSetOutline(CallingTD[8], 1);
	TextDrawSetShadow(CallingTD[8], 0);
	TextDrawAlignment(CallingTD[8], 1);
	TextDrawColor(CallingTD[8], 255);
	TextDrawBackgroundColor(CallingTD[8], 255);
	TextDrawBoxColor(CallingTD[8], 50);
	TextDrawUseBox(CallingTD[8], 1);
	TextDrawSetProportional(CallingTD[8], 1);
	TextDrawSetSelectable(CallingTD[8], 0);

	CallingTD[9] = TextDrawCreate(484.000000, 413.000000, "ld_pool:ball");
	TextDrawFont(CallingTD[9], 4);
	TextDrawLetterSize(CallingTD[9], 0.600000, 2.000000);
	TextDrawTextSize(CallingTD[9], 10.000000, 10.000000);
	TextDrawSetOutline(CallingTD[9], 1);
	TextDrawSetShadow(CallingTD[9], 0);
	TextDrawAlignment(CallingTD[9], 1);
	TextDrawColor(CallingTD[9], 255);
	TextDrawBackgroundColor(CallingTD[9], 255);
	TextDrawBoxColor(CallingTD[9], 50);
	TextDrawUseBox(CallingTD[9], 1);
	TextDrawSetProportional(CallingTD[9], 1);
	TextDrawSetSelectable(CallingTD[9], 0);

	CallingTD[10] = TextDrawCreate(435.000000, 188.000000, "_");
	TextDrawFont(CallingTD[10], 1);
	TextDrawLetterSize(CallingTD[10], 0.600000, 0.650004);
	TextDrawTextSize(CallingTD[10], 298.500000, 111.500000);
	TextDrawSetOutline(CallingTD[10], 1);
	TextDrawSetShadow(CallingTD[10], 0);
	TextDrawAlignment(CallingTD[10], 2);
	TextDrawColor(CallingTD[10], -1);
	TextDrawBackgroundColor(CallingTD[10], 255);
	TextDrawBoxColor(CallingTD[10], 1296911871);
	TextDrawUseBox(CallingTD[10], 1);
	TextDrawSetProportional(CallingTD[10], 1);
	TextDrawSetSelectable(CallingTD[10], 0);

	CallingTD[11] = TextDrawCreate(380.000000, 185.000000, "5G____________00:00");
	TextDrawFont(CallingTD[11], 2);
	TextDrawLetterSize(CallingTD[11], 0.333332, 1.049998);
	TextDrawTextSize(CallingTD[11], 400.000000, 17.000000);
	TextDrawSetOutline(CallingTD[11], 1);
	TextDrawSetShadow(CallingTD[11], 0);
	TextDrawAlignment(CallingTD[11], 1);
	TextDrawColor(CallingTD[11], -1);
	TextDrawBackgroundColor(CallingTD[11], 255);
	TextDrawBoxColor(CallingTD[11], 50);
	TextDrawUseBox(CallingTD[11], 0);
	TextDrawSetProportional(CallingTD[11], 1);
	TextDrawSetSelectable(CallingTD[11], 0);

	CallingTD[12] = TextDrawCreate(435.000000, 378.000000, "_");
	TextDrawFont(CallingTD[12], 1);
	TextDrawLetterSize(CallingTD[12], 0.600000, 2.250004);
	TextDrawTextSize(CallingTD[12], 298.500000, 111.500000);
	TextDrawSetOutline(CallingTD[12], 1);
	TextDrawSetShadow(CallingTD[12], 0);
	TextDrawAlignment(CallingTD[12], 2);
	TextDrawColor(CallingTD[12], -1);
	TextDrawBackgroundColor(CallingTD[12], 255);
	TextDrawBoxColor(CallingTD[12], 1296911871);
	TextDrawUseBox(CallingTD[12], 1);
	TextDrawSetProportional(CallingTD[12], 1);
	TextDrawSetSelectable(CallingTD[12], 0);

	PICKUP = TextDrawCreate(380.000000, 375.000000, "ld_chat:thumbup");
	TextDrawFont(PICKUP, 4);
	TextDrawLetterSize(PICKUP, 0.600000, 2.000000);
	TextDrawTextSize(PICKUP, 19.500000, 26.000000);
	TextDrawSetOutline(PICKUP, 1);
	TextDrawSetShadow(PICKUP, 0);
	TextDrawAlignment(PICKUP, 1);
	TextDrawColor(PICKUP, -1);
	TextDrawBackgroundColor(PICKUP, 255);
	TextDrawBoxColor(PICKUP, 50);
	TextDrawUseBox(PICKUP, 1);
	TextDrawSetProportional(PICKUP, 1);
	TextDrawSetSelectable(PICKUP, 1);

	HANGUP = TextDrawCreate(471.000000, 375.000000, "ld_chat:thumbdn");
	TextDrawFont(HANGUP, 4);
	TextDrawLetterSize(HANGUP, 0.600000, 2.000000);
	TextDrawTextSize(HANGUP, 19.500000, 26.000000);
	TextDrawSetOutline(HANGUP, 1);
	TextDrawSetShadow(HANGUP, 0);
	TextDrawAlignment(HANGUP, 1);
	TextDrawColor(HANGUP, -1);
	TextDrawBackgroundColor(HANGUP, 255);
	TextDrawBoxColor(HANGUP, 50);
	TextDrawUseBox(HANGUP, 1);
	TextDrawSetProportional(HANGUP, 1);
	TextDrawSetSelectable(HANGUP, 1);

	CloseCallTD = TextDrawCreate(425.000000, 399.000000, "ld_pool:ball");
	TextDrawFont(CloseCallTD, 4);
	TextDrawLetterSize(CloseCallTD, 0.600000, 2.000000);
	TextDrawTextSize(CloseCallTD, 21.500000, 23.000000);
	TextDrawSetOutline(CloseCallTD, 1);
	TextDrawSetShadow(CloseCallTD, 0);
	TextDrawAlignment(CloseCallTD, 1);
	TextDrawColor(CloseCallTD, 1296911871);
	TextDrawBackgroundColor(CloseCallTD, 255);
	TextDrawBoxColor(CloseCallTD, 1296911666);
	TextDrawUseBox(CloseCallTD, 1);
	TextDrawSetProportional(CloseCallTD, 1);
	TextDrawSetSelectable(CloseCallTD, 1);

	TwitterApp[0] = TextDrawCreate(375.000000, 170.000000, "ld_pool:ball");
	TextDrawFont(TwitterApp[0], 4);
	TextDrawLetterSize(TwitterApp[0], 0.600000, 2.000000);
	TextDrawTextSize(TwitterApp[0], 17.000000, 17.000000);
	TextDrawSetOutline(TwitterApp[0], 1);
	TextDrawSetShadow(TwitterApp[0], 0);
	TextDrawAlignment(TwitterApp[0], 1);
	TextDrawColor(TwitterApp[0], 255);
	TextDrawBackgroundColor(TwitterApp[0], 255);
	TextDrawBoxColor(TwitterApp[0], 50);
	TextDrawUseBox(TwitterApp[0], 1);
	TextDrawSetProportional(TwitterApp[0], 1);
	TextDrawSetSelectable(TwitterApp[0], 0);

	TwitterApp[1] = TextDrawCreate(478.000000, 171.000000, "ld_pool:ball");
	TextDrawFont(TwitterApp[1], 4);
	TextDrawLetterSize(TwitterApp[1], 0.600000, 2.000000);
	TextDrawTextSize(TwitterApp[1], 17.000000, 17.000000);
	TextDrawSetOutline(TwitterApp[1], 1);
	TextDrawSetShadow(TwitterApp[1], 0);
	TextDrawAlignment(TwitterApp[1], 1);
	TextDrawColor(TwitterApp[1], 255);
	TextDrawBackgroundColor(TwitterApp[1], 255);
	TextDrawBoxColor(TwitterApp[1], 50);
	TextDrawUseBox(TwitterApp[1], 1);
	TextDrawSetProportional(TwitterApp[1], 1);
	TextDrawSetSelectable(TwitterApp[1], 0);

	TwitterApp[2] = TextDrawCreate(435.000000, 178.000000, "_");
	TextDrawFont(TwitterApp[2], 1);
	TextDrawLetterSize(TwitterApp[2], 0.600000, 26.300064);
	TextDrawTextSize(TwitterApp[2], 298.500000, 115.500000);
	TextDrawSetOutline(TwitterApp[2], 1);
	TextDrawSetShadow(TwitterApp[2], 0);
	TextDrawAlignment(TwitterApp[2], 2);
	TextDrawColor(TwitterApp[2], -1);
	TextDrawBackgroundColor(TwitterApp[2], 255);
	TextDrawBoxColor(TwitterApp[2], 255);
	TextDrawUseBox(TwitterApp[2], 1);
	TextDrawSetProportional(TwitterApp[2], 1);
	TextDrawSetSelectable(TwitterApp[2], 0);

	TwitterApp[0] = TextDrawCreate(435.000000, 178.000000, "_");
	TextDrawFont(TwitterApp[0], 1);
	TextDrawLetterSize(TwitterApp[0], 0.600000, 26.300064);
	TextDrawTextSize(TwitterApp[0], 298.500000, 115.500000);
	TextDrawSetOutline(TwitterApp[0], 1);
	TextDrawSetShadow(TwitterApp[0], 0);
	TextDrawAlignment(TwitterApp[0], 2);
	TextDrawColor(TwitterApp[0], -1);
	TextDrawBackgroundColor(TwitterApp[0], 255);
	TextDrawBoxColor(TwitterApp[0], 255);
	TextDrawUseBox(TwitterApp[0], 1);
	TextDrawSetProportional(TwitterApp[0], 1);
	TextDrawSetSelectable(TwitterApp[0], 0);

	TwitterApp[1] = TextDrawCreate(435.000000, 173.000000, "_");
	TextDrawFont(TwitterApp[1], 1);
	TextDrawLetterSize(TwitterApp[1], 0.600000, 27.450054);
	TextDrawTextSize(TwitterApp[1], 298.500000, 104.500000);
	TextDrawSetOutline(TwitterApp[1], 1);
	TextDrawSetShadow(TwitterApp[1], 0);
	TextDrawAlignment(TwitterApp[1], 2);
	TextDrawColor(TwitterApp[1], -1);
	TextDrawBackgroundColor(TwitterApp[1], 255);
	TextDrawBoxColor(TwitterApp[1], 255);
	TextDrawUseBox(TwitterApp[1], 1);
	TextDrawSetProportional(TwitterApp[1], 1);
	TextDrawSetSelectable(TwitterApp[1], 0);

	TwitterApp[2] = TextDrawCreate(435.000000, 188.000000, "_");
	TextDrawFont(TwitterApp[2], 1);
	TextDrawLetterSize(TwitterApp[2], 0.433333, 23.150011);
	TextDrawTextSize(TwitterApp[2], 298.500000, 111.500000);
	TextDrawSetOutline(TwitterApp[2], 1);
	TextDrawSetShadow(TwitterApp[2], 0);
	TextDrawAlignment(TwitterApp[2], 2);
	TextDrawColor(TwitterApp[2], -1);
	TextDrawBackgroundColor(TwitterApp[2], 255);
	TextDrawBoxColor(TwitterApp[2], -1061109625);
	TextDrawUseBox(TwitterApp[2], 1);
	TextDrawSetProportional(TwitterApp[2], 1);
	TextDrawSetSelectable(TwitterApp[2], 0);

	TwitterApp[3] = TextDrawCreate(435.000000, 188.000000, "_");
	TextDrawFont(TwitterApp[3], 1);
	TextDrawLetterSize(TwitterApp[3], 0.433333, 23.150011);
	TextDrawTextSize(TwitterApp[3], 298.500000, 111.500000);
	TextDrawSetOutline(TwitterApp[3], 1);
	TextDrawSetShadow(TwitterApp[3], 0);
	TextDrawAlignment(TwitterApp[3], 2);
	TextDrawColor(TwitterApp[3], -1);
	TextDrawBackgroundColor(TwitterApp[3], 255);
	TextDrawBoxColor(TwitterApp[3], 1687547271);
	TextDrawUseBox(TwitterApp[3], 1);
	TextDrawSetProportional(TwitterApp[3], 1);
	TextDrawSetSelectable(TwitterApp[3], 0);

	TwitterApp[4] = TextDrawCreate(408.000000, 175.000000, "PHLRP PHONE");
	TextDrawFont(TwitterApp[4], 1);
	TextDrawLetterSize(TwitterApp[4], 0.258332, 0.699998);
	TextDrawTextSize(TwitterApp[4], 611.000000, -194.500000);
	TextDrawSetOutline(TwitterApp[4], 1);
	TextDrawSetShadow(TwitterApp[4], 0);
	TextDrawAlignment(TwitterApp[4], 1);
	TextDrawColor(TwitterApp[4], -1);
	TextDrawBackgroundColor(TwitterApp[4], 255);
	TextDrawBoxColor(TwitterApp[4], 50);
	TextDrawUseBox(TwitterApp[4], 0);
	TextDrawSetProportional(TwitterApp[4], 1);
	TextDrawSetSelectable(TwitterApp[4], 0);

	TwitterApp[5] = TextDrawCreate(480.000000, 176.000000, "ld_pool:ball");
	TextDrawFont(TwitterApp[5], 4);
	TextDrawLetterSize(TwitterApp[5], 0.600000, 2.000000);
	TextDrawTextSize(TwitterApp[5], 4.000000, 5.500000);
	TextDrawSetOutline(TwitterApp[5], 1);
	TextDrawSetShadow(TwitterApp[5], 0);
	TextDrawAlignment(TwitterApp[5], 1);
	TextDrawColor(TwitterApp[5], 1296911871);
	TextDrawBackgroundColor(TwitterApp[5], 255);
	TextDrawBoxColor(TwitterApp[5], 1296911666);
	TextDrawUseBox(TwitterApp[5], 1);
	TextDrawSetProportional(TwitterApp[5], 1);
	TextDrawSetSelectable(TwitterApp[5], 0);

	TwitterApp[6] = TextDrawCreate(376.000000, 413.000000, "ld_pool:ball");
	TextDrawFont(TwitterApp[6], 4);
	TextDrawLetterSize(TwitterApp[6], 0.600000, 2.000000);
	TextDrawTextSize(TwitterApp[6], 10.000000, 10.000000);
	TextDrawSetOutline(TwitterApp[6], 1);
	TextDrawSetShadow(TwitterApp[6], 0);
	TextDrawAlignment(TwitterApp[6], 1);
	TextDrawColor(TwitterApp[6], 255);
	TextDrawBackgroundColor(TwitterApp[6], 255);
	TextDrawBoxColor(TwitterApp[6], 50);
	TextDrawUseBox(TwitterApp[6], 1);
	TextDrawSetProportional(TwitterApp[6], 1);
	TextDrawSetSelectable(TwitterApp[6], 0);

	TwitterApp[7] = TextDrawCreate(484.000000, 413.000000, "ld_pool:ball");
	TextDrawFont(TwitterApp[7], 4);
	TextDrawLetterSize(TwitterApp[7], 0.600000, 2.000000);
	TextDrawTextSize(TwitterApp[7], 10.000000, 10.000000);
	TextDrawSetOutline(TwitterApp[7], 1);
	TextDrawSetShadow(TwitterApp[7], 0);
	TextDrawAlignment(TwitterApp[7], 1);
	TextDrawColor(TwitterApp[7], 255);
	TextDrawBackgroundColor(TwitterApp[7], 255);
	TextDrawBoxColor(TwitterApp[7], 50);
	TextDrawUseBox(TwitterApp[7], 1);
	TextDrawSetProportional(TwitterApp[7], 1);
	TextDrawSetSelectable(TwitterApp[7], 0);

	TwitterApp[8] = TextDrawCreate(399.000000, 195.000000, "_");
	TextDrawFont(TwitterApp[8], 1);
	TextDrawLetterSize(TwitterApp[8], 0.600000, 1.500003);
	TextDrawTextSize(TwitterApp[8], 298.500000, 40.000000);
	TextDrawSetOutline(TwitterApp[8], 1);
	TextDrawSetShadow(TwitterApp[8], 0);
	TextDrawAlignment(TwitterApp[8], 2);
	TextDrawColor(TwitterApp[8], -1);
	TextDrawBackgroundColor(TwitterApp[8], 255);
	TextDrawBoxColor(TwitterApp[8], 16777215);
	TextDrawUseBox(TwitterApp[8], 1);
	TextDrawSetProportional(TwitterApp[8], 1);
	TextDrawSetSelectable(TwitterApp[8], 0);

	TwitterApp[9] = TextDrawCreate(380.000000, 196.000000, "Twitter");
	TextDrawFont(TwitterApp[9], 1);
	TextDrawLetterSize(TwitterApp[9], 0.299999, 0.999999);
	TextDrawTextSize(TwitterApp[9], 400.000000, 17.000000);
	TextDrawSetOutline(TwitterApp[9], 1);
	TextDrawSetShadow(TwitterApp[9], 0);
	TextDrawAlignment(TwitterApp[9], 1);
	TextDrawColor(TwitterApp[9], -1);
	TextDrawBackgroundColor(TwitterApp[9], 255);
	TextDrawBoxColor(TwitterApp[9], 50);
	TextDrawUseBox(TwitterApp[9], 0);
	TextDrawSetProportional(TwitterApp[9], 1);
	TextDrawSetSelectable(TwitterApp[9], 0);

	TwitterApp[10] = TextDrawCreate(435.000000, 376.000000, "_");
	TextDrawFont(TwitterApp[10], 1);
	TextDrawLetterSize(TwitterApp[10], 0.600000, 2.250004);
	TextDrawTextSize(TwitterApp[10], 298.500000, 111.500000);
	TextDrawSetOutline(TwitterApp[10], 1);
	TextDrawSetShadow(TwitterApp[10], 0);
	TextDrawAlignment(TwitterApp[10], 2);
	TextDrawColor(TwitterApp[10], -1);
	TextDrawBackgroundColor(TwitterApp[10], 255);
	TextDrawBoxColor(TwitterApp[10], 1296911871);
	TextDrawUseBox(TwitterApp[10], 1);
	TextDrawSetProportional(TwitterApp[10], 1);
	TextDrawSetSelectable(TwitterApp[10], 0);

	TwitterApp[11] = TextDrawCreate(435.000000, 239.000000, "_");
	TextDrawFont(TwitterApp[11], 1);
	TextDrawLetterSize(TwitterApp[11], 0.600000, 7.800005);
	TextDrawTextSize(TwitterApp[11], 298.500000, 111.500000);
	TextDrawSetOutline(TwitterApp[11], 1);
	TextDrawSetShadow(TwitterApp[11], 0);
	TextDrawAlignment(TwitterApp[11], 2);
	TextDrawColor(TwitterApp[11], -1);
	TextDrawBackgroundColor(TwitterApp[11], 255);
	TextDrawBoxColor(TwitterApp[11], -1);
	TextDrawUseBox(TwitterApp[11], 1);
	TextDrawSetProportional(TwitterApp[11], 1);
	TextDrawSetSelectable(TwitterApp[11], 0);

	TwitterApp[12] = TextDrawCreate(378.000000, 225.000000, "What's happening?");
	TextDrawFont(TwitterApp[12], 2);
	TextDrawLetterSize(TwitterApp[12], 0.158332, 1.199998);
	TextDrawTextSize(TwitterApp[12], 620.000000, 17.000000);
	TextDrawSetOutline(TwitterApp[12], 1);
	TextDrawSetShadow(TwitterApp[12], 0);
	TextDrawAlignment(TwitterApp[12], 1);
	TextDrawColor(TwitterApp[12], -1);
	TextDrawBackgroundColor(TwitterApp[12], 255);
	TextDrawBoxColor(TwitterApp[12], 50);
	TextDrawUseBox(TwitterApp[12], 0);
	TextDrawSetProportional(TwitterApp[12], 1);
	TextDrawSetSelectable(TwitterApp[12], 0);

	TwitterApp[13] = TextDrawCreate(435.000000, 238.000000, "_");
	TextDrawFont(TwitterApp[13], 1);
	TextDrawLetterSize(TwitterApp[13], 0.600000, -0.399998);
	TextDrawTextSize(TwitterApp[13], 298.500000, 111.500000);
	TextDrawSetOutline(TwitterApp[13], 1);
	TextDrawSetShadow(TwitterApp[13], 0);
	TextDrawAlignment(TwitterApp[13], 2);
	TextDrawColor(TwitterApp[13], -1);
	TextDrawBackgroundColor(TwitterApp[13], 255);
	TextDrawBoxColor(TwitterApp[13], 16777215);
	TextDrawUseBox(TwitterApp[13], 1);
	TextDrawSetProportional(TwitterApp[13], 1);
	TextDrawSetSelectable(TwitterApp[13], 0);

	TwitterApp[14] = TextDrawCreate(435.000000, 315.000000, "_");
	TextDrawFont(TwitterApp[14], 1);
	TextDrawLetterSize(TwitterApp[14], 0.600000, -0.399998);
	TextDrawTextSize(TwitterApp[14], 298.500000, 111.500000);
	TextDrawSetOutline(TwitterApp[14], 1);
	TextDrawSetShadow(TwitterApp[14], 0);
	TextDrawAlignment(TwitterApp[14], 2);
	TextDrawColor(TwitterApp[14], -1);
	TextDrawBackgroundColor(TwitterApp[14], 255);
	TextDrawBoxColor(TwitterApp[14], 16777215);
	TextDrawUseBox(TwitterApp[14], 1);
	TextDrawSetProportional(TwitterApp[14], 1);
	TextDrawSetSelectable(TwitterApp[14], 0);

	TwitterApp[15] = TextDrawCreate(426.000000, 328.000000, "50 characters");
	TextDrawFont(TwitterApp[15], 2);
	TextDrawLetterSize(TwitterApp[15], 0.116665, 1.699998);
	TextDrawTextSize(TwitterApp[15], 620.000000, 17.000000);
	TextDrawSetOutline(TwitterApp[15], 1);
	TextDrawSetShadow(TwitterApp[15], 0);
	TextDrawAlignment(TwitterApp[15], 1);
	TextDrawColor(TwitterApp[15], -1);
	TextDrawBackgroundColor(TwitterApp[15], 255);
	TextDrawBoxColor(TwitterApp[15], 50);
	TextDrawUseBox(TwitterApp[15], 0);
	TextDrawSetProportional(TwitterApp[15], 1);
	TextDrawSetSelectable(TwitterApp[15], 0);

	TwitterApp[16] = TextDrawCreate(480.000000, 328.000000, "_");
	TextDrawFont(TwitterApp[16], 1);
	TextDrawLetterSize(TwitterApp[16], 0.600000, 1.350003);
	TextDrawTextSize(TwitterApp[16], 298.500000, 21.500000);
	TextDrawSetOutline(TwitterApp[16], 1);
	TextDrawSetShadow(TwitterApp[16], 0);
	TextDrawAlignment(TwitterApp[16], 2);
	TextDrawColor(TwitterApp[16], -1);
	TextDrawBackgroundColor(TwitterApp[16], 255);
	TextDrawBoxColor(TwitterApp[16], 1296911871);
	TextDrawUseBox(TwitterApp[16], 1);
	TextDrawSetProportional(TwitterApp[16], 1);
	TextDrawSetSelectable(TwitterApp[16], 0);

	TwitterApp[17] = TextDrawCreate(470.000000, 329.000000, "Tweet");
	TextDrawFont(TwitterApp[17], 2);
	TextDrawLetterSize(TwitterApp[17], 0.137499, 1.049999);
	TextDrawTextSize(TwitterApp[17], 620.000000, 17.000000);
	TextDrawSetOutline(TwitterApp[17], 1);
	TextDrawSetShadow(TwitterApp[17], 0);
	TextDrawAlignment(TwitterApp[17], 1);
	TextDrawColor(TwitterApp[17], -1);
	TextDrawBackgroundColor(TwitterApp[17], 255);
	TextDrawBoxColor(TwitterApp[17], 50);
	TextDrawUseBox(TwitterApp[17], 0);
	TextDrawSetProportional(TwitterApp[17], 1);
	TextDrawSetSelectable(TwitterApp[17], 0);

	TwitterApp[18] = TextDrawCreate(460.000000, 195.000000, "_");
	TextDrawFont(TwitterApp[18], 1);
	TextDrawLetterSize(TwitterApp[18], 0.600000, 1.500003);
	TextDrawTextSize(TwitterApp[18], 298.500000, 61.500000);
	TextDrawSetOutline(TwitterApp[18], 1);
	TextDrawSetShadow(TwitterApp[18], 0);
	TextDrawAlignment(TwitterApp[18], 2);
	TextDrawColor(TwitterApp[18], -1);
	TextDrawBackgroundColor(TwitterApp[18], 255);
	TextDrawBoxColor(TwitterApp[18], -1);
	TextDrawUseBox(TwitterApp[18], 1);
	TextDrawSetProportional(TwitterApp[18], 1);
	TextDrawSetSelectable(TwitterApp[18], 0);

	TwitterApp[19] = TextDrawCreate(429.000000, 197.000000, "Home    Profile    Find People");
	TextDrawFont(TwitterApp[19], 2);
	TextDrawLetterSize(TwitterApp[19], 0.091665, 1.049999);
	TextDrawTextSize(TwitterApp[19], 620.000000, 17.000000);
	TextDrawSetOutline(TwitterApp[19], 1);
	TextDrawSetShadow(TwitterApp[19], 0);
	TextDrawAlignment(TwitterApp[19], 1);
	TextDrawColor(TwitterApp[19], -1);
	TextDrawBackgroundColor(TwitterApp[19], 255);
	TextDrawBoxColor(TwitterApp[19], 50);
	TextDrawUseBox(TwitterApp[19], 0);
	TextDrawSetProportional(TwitterApp[19], 1);
	TextDrawSetSelectable(TwitterApp[19], 0);

	addtexttd = TextDrawCreate(402.000000, 263.000000, "CLICK TO ADD TEXT");
	TextDrawFont(addtexttd, 2);
	TextDrawLetterSize(addtexttd, 0.158332, 1.199998);
	TextDrawTextSize(addtexttd, 474.000000, 17.000000);
	TextDrawSetOutline(addtexttd, 1);
	TextDrawSetShadow(addtexttd, 0);
	TextDrawAlignment(addtexttd, 1);
	TextDrawColor(addtexttd, -1);
	TextDrawBackgroundColor(addtexttd, 255);
	TextDrawBoxColor(addtexttd, 50);
	TextDrawUseBox(addtexttd, 0);
	TextDrawSetProportional(addtexttd, 1);
	TextDrawSetSelectable(addtexttd, 1);
	//Textdraws
	PhoneTD[0] = TextDrawCreate(375.000000, 170.000000, "ld_pool:ball");
	TextDrawFont(PhoneTD[0], 4);
	TextDrawLetterSize(PhoneTD[0], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[0], 17.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[0], 1);
	TextDrawSetShadow(PhoneTD[0], 0);
	TextDrawAlignment(PhoneTD[0], 1);
	TextDrawColor(PhoneTD[0], 255);
	TextDrawBackgroundColor(PhoneTD[0], 255);
	TextDrawBoxColor(PhoneTD[0], 50);
	TextDrawUseBox(PhoneTD[0], 1);
	TextDrawSetProportional(PhoneTD[0], 1);
	TextDrawSetSelectable(PhoneTD[0], 0);

	PhoneTD[1] = TextDrawCreate(478.000000, 171.000000, "ld_pool:ball");
	TextDrawFont(PhoneTD[1], 4);
	TextDrawLetterSize(PhoneTD[1], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[1], 17.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[1], 1);
	TextDrawSetShadow(PhoneTD[1], 0);
	TextDrawAlignment(PhoneTD[1], 1);
	TextDrawColor(PhoneTD[1], 255);
	TextDrawBackgroundColor(PhoneTD[1], 255);
	TextDrawBoxColor(PhoneTD[1], 50);
	TextDrawUseBox(PhoneTD[1], 1);
	TextDrawSetProportional(PhoneTD[1], 1);
	TextDrawSetSelectable(PhoneTD[1], 0);

	PhoneTD[2] = TextDrawCreate(435.000000, 178.000000, "_");
	TextDrawFont(PhoneTD[2], 1);
	TextDrawLetterSize(PhoneTD[2], 0.600000, 26.300064);
	TextDrawTextSize(PhoneTD[2], 298.500000, 115.500000);
	TextDrawSetOutline(PhoneTD[2], 1);
	TextDrawSetShadow(PhoneTD[2], 0);
	TextDrawAlignment(PhoneTD[2], 2);
	TextDrawColor(PhoneTD[2], -1);
	TextDrawBackgroundColor(PhoneTD[2], 255);
	TextDrawBoxColor(PhoneTD[2], 255);
	TextDrawUseBox(PhoneTD[2], 1);
	TextDrawSetProportional(PhoneTD[2], 1);
	TextDrawSetSelectable(PhoneTD[2], 0);

	PhoneTD[3] = TextDrawCreate(435.000000, 173.000000, "_");
	TextDrawFont(PhoneTD[3], 1);
	TextDrawLetterSize(PhoneTD[3], 0.600000, 27.450054);
	TextDrawTextSize(PhoneTD[3], 298.500000, 104.500000);
	TextDrawSetOutline(PhoneTD[3], 1);
	TextDrawSetShadow(PhoneTD[3], 0);
	TextDrawAlignment(PhoneTD[3], 2);
	TextDrawColor(PhoneTD[3], -1);
	TextDrawBackgroundColor(PhoneTD[3], 255);
	TextDrawBoxColor(PhoneTD[3], 255);
	TextDrawUseBox(PhoneTD[3], 1);
	TextDrawSetProportional(PhoneTD[3], 1);
	TextDrawSetSelectable(PhoneTD[3], 0);

	PhoneTD[4] = TextDrawCreate(435.000000, 188.000000, "_");
	TextDrawFont(PhoneTD[4], 1);
	TextDrawLetterSize(PhoneTD[4], 0.433333, 23.150011);
	TextDrawTextSize(PhoneTD[4], 298.500000, 111.500000);
	TextDrawSetOutline(PhoneTD[4], 1);
	TextDrawSetShadow(PhoneTD[4], 0);
	TextDrawAlignment(PhoneTD[4], 2);
	TextDrawColor(PhoneTD[4], -1);
	TextDrawBackgroundColor(PhoneTD[4], 255);
	TextDrawBoxColor(PhoneTD[4], -1061109625);
	TextDrawUseBox(PhoneTD[4], 1);
	TextDrawSetProportional(PhoneTD[4], 1);
	TextDrawSetSelectable(PhoneTD[4], 0);

	PhoneTD[19] = TextDrawCreate(386.000000, 340.000000, "Twitter");
	TextDrawFont(PhoneTD[19], 2);
	TextDrawLetterSize(PhoneTD[19], 0.145833, 1.149999);
	TextDrawTextSize(PhoneTD[19], 490.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[19], 1);
	TextDrawSetShadow(PhoneTD[19], 0);
	TextDrawAlignment(PhoneTD[19], 1);
	TextDrawColor(PhoneTD[19], -1);
	TextDrawBackgroundColor(PhoneTD[19], 255);
	TextDrawBoxColor(PhoneTD[19], 50);
	TextDrawUseBox(PhoneTD[19], 0);
	TextDrawSetProportional(PhoneTD[19], 1);
	TextDrawSetSelectable(PhoneTD[19], 0);

	PhoneTD[5] = TextDrawCreate(378.000000, 187.000000, "ld_bum:bum2");
	TextDrawFont(PhoneTD[5], 4);
	TextDrawLetterSize(PhoneTD[5], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[5], 114.500000, 189.000000);
	TextDrawSetOutline(PhoneTD[5], 1);
	TextDrawSetShadow(PhoneTD[5], 0);
	TextDrawAlignment(PhoneTD[5], 1);
	TextDrawColor(PhoneTD[5], -1);
	TextDrawBackgroundColor(PhoneTD[5], 255);
	TextDrawBoxColor(PhoneTD[5], 50);
	TextDrawUseBox(PhoneTD[5], 1);
	TextDrawSetProportional(PhoneTD[5], 1);
	TextDrawSetSelectable(PhoneTD[5], 0);

	phoneclosetd = TextDrawCreate(425.000000, 399.000000, "ld_pool:ball");
	TextDrawFont(phoneclosetd, 4);
	TextDrawLetterSize(phoneclosetd, 0.600000, 2.000000);
	TextDrawTextSize(phoneclosetd, 21.500000, 23.000000);
	TextDrawSetOutline(phoneclosetd, 1);
	TextDrawSetShadow(phoneclosetd, 0);
	TextDrawAlignment(phoneclosetd, 1);
	TextDrawColor(phoneclosetd, 1296911871);
	TextDrawBackgroundColor(phoneclosetd, 255);
	TextDrawBoxColor(phoneclosetd, 1296911666);
	TextDrawUseBox(phoneclosetd, 1);
	TextDrawSetProportional(phoneclosetd, 1);
	TextDrawSetSelectable(phoneclosetd, 1);

	PhoneTD[6] = TextDrawCreate(408.000000, 175.000000, "PHLRP PHONE");
	TextDrawFont(PhoneTD[6], 1);
	TextDrawLetterSize(PhoneTD[6], 0.258332, 0.699998);
	TextDrawTextSize(PhoneTD[6], 611.000000, -194.500000);
	TextDrawSetOutline(PhoneTD[6], 1);
	TextDrawSetShadow(PhoneTD[6], 0);
	TextDrawAlignment(PhoneTD[6], 1);
	TextDrawColor(PhoneTD[6], -1);
	TextDrawBackgroundColor(PhoneTD[6], 255);
	TextDrawBoxColor(PhoneTD[6], 50);
	TextDrawUseBox(PhoneTD[6], 0);
	TextDrawSetProportional(PhoneTD[6], 1);
	TextDrawSetSelectable(PhoneTD[6], 0);

	PhoneTD[7] = TextDrawCreate(480.000000, 176.000000, "ld_pool:ball");
	TextDrawFont(PhoneTD[7], 4);
	TextDrawLetterSize(PhoneTD[7], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[7], 4.000000, 5.500000);
	TextDrawSetOutline(PhoneTD[7], 1);
	TextDrawSetShadow(PhoneTD[7], 0);
	TextDrawAlignment(PhoneTD[7], 1);
	TextDrawColor(PhoneTD[7], 1296911871);
	TextDrawBackgroundColor(PhoneTD[7], 255);
	TextDrawBoxColor(PhoneTD[7], 1296911666);
	TextDrawUseBox(PhoneTD[7], 1);
	TextDrawSetProportional(PhoneTD[7], 1);
	TextDrawSetSelectable(PhoneTD[7], 0);

	PhoneTD[8] = TextDrawCreate(376.000000, 413.000000, "ld_pool:ball");
	TextDrawFont(PhoneTD[8], 4);
	TextDrawLetterSize(PhoneTD[8], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[8], 10.000000, 10.000000);
	TextDrawSetOutline(PhoneTD[8], 1);
	TextDrawSetShadow(PhoneTD[8], 0);
	TextDrawAlignment(PhoneTD[8], 1);
	TextDrawColor(PhoneTD[8], 255);
	TextDrawBackgroundColor(PhoneTD[8], 255);
	TextDrawBoxColor(PhoneTD[8], 50);
	TextDrawUseBox(PhoneTD[8], 1);
	TextDrawSetProportional(PhoneTD[8], 1);
	TextDrawSetSelectable(PhoneTD[8], 0);

	PhoneTD[9] = TextDrawCreate(484.000000, 413.000000, "ld_pool:ball");
	TextDrawFont(PhoneTD[9], 4);
	TextDrawLetterSize(PhoneTD[9], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[9], 10.000000, 10.000000);
	TextDrawSetOutline(PhoneTD[9], 1);
	TextDrawSetShadow(PhoneTD[9], 0);
	TextDrawAlignment(PhoneTD[9], 1);
	TextDrawColor(PhoneTD[9], 255);
	TextDrawBackgroundColor(PhoneTD[9], 255);
	TextDrawBoxColor(PhoneTD[9], 50);
	TextDrawUseBox(PhoneTD[9], 1);
	TextDrawSetProportional(PhoneTD[9], 1);
	TextDrawSetSelectable(PhoneTD[9], 0);

	PhoneTD[10] = TextDrawCreate(435.000000, 188.000000, "_");
	TextDrawFont(PhoneTD[10], 1);
	TextDrawLetterSize(PhoneTD[10], 0.600000, 0.650004);
	TextDrawTextSize(PhoneTD[10], 298.500000, 111.500000);
	TextDrawSetOutline(PhoneTD[10], 1);
	TextDrawSetShadow(PhoneTD[10], 0);
	TextDrawAlignment(PhoneTD[10], 2);
	TextDrawColor(PhoneTD[10], -1);
	TextDrawBackgroundColor(PhoneTD[10], 255);
	TextDrawBoxColor(PhoneTD[10], 1296911871);
	TextDrawUseBox(PhoneTD[10], 1);
	TextDrawSetProportional(PhoneTD[10], 1);
	TextDrawSetSelectable(PhoneTD[10], 0);

	PhoneTD[11] = TextDrawCreate(380.000000, 185.000000, "5G____________00:00");
	TextDrawFont(PhoneTD[11], 2);
	TextDrawLetterSize(PhoneTD[11], 0.333332, 1.049999);
	TextDrawTextSize(PhoneTD[11], 400.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[11], 1);
	TextDrawSetShadow(PhoneTD[11], 0);
	TextDrawAlignment(PhoneTD[11], 1);
	TextDrawColor(PhoneTD[11], -1);
	TextDrawBackgroundColor(PhoneTD[11], 255);
	TextDrawBoxColor(PhoneTD[11], 50);
	TextDrawUseBox(PhoneTD[11], 0);
	TextDrawSetProportional(PhoneTD[11], 1);
	TextDrawSetSelectable(PhoneTD[11], 0);

	PhoneTD[12] = TextDrawCreate(435.000000, 378.000000, "_");
	TextDrawFont(PhoneTD[12], 1);
	TextDrawLetterSize(PhoneTD[12], 0.600000, 2.250004);
	TextDrawTextSize(PhoneTD[12], 298.500000, 111.500000);
	TextDrawSetOutline(PhoneTD[12], 1);
	TextDrawSetShadow(PhoneTD[12], 0);
	TextDrawAlignment(PhoneTD[12], 2);
	TextDrawColor(PhoneTD[12], -1);
	TextDrawBackgroundColor(PhoneTD[12], 255);
	TextDrawBoxColor(PhoneTD[12], 1296911871);
	TextDrawUseBox(PhoneTD[12], 1);
	TextDrawSetProportional(PhoneTD[12], 1);
	TextDrawSetSelectable(PhoneTD[12], 0);

	PhoneTD[13] = TextDrawCreate(428.000000, 376.000000, "...~n~...~n~...");
	TextDrawFont(PhoneTD[13], 2);
	TextDrawLetterSize(PhoneTD[13], 0.529165, 0.750000);
	TextDrawTextSize(PhoneTD[13], 400.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[13], 1);
	TextDrawSetShadow(PhoneTD[13], 0);
	TextDrawAlignment(PhoneTD[13], 1);
	TextDrawColor(PhoneTD[13], -1);
	TextDrawBackgroundColor(PhoneTD[13], 255);
	TextDrawBoxColor(PhoneTD[13], 50);
	TextDrawUseBox(PhoneTD[13], 0);
	TextDrawSetProportional(PhoneTD[13], 1);
	TextDrawSetSelectable(PhoneTD[13], 0);

	mesaagetd = TextDrawCreate(389.000000, 208.000000, "ld_chat:goodcha");
	TextDrawFont(mesaagetd, 4);
	TextDrawLetterSize(mesaagetd, 0.600000, 2.000000);
	TextDrawTextSize(mesaagetd, 20.000000, 18.500000);
	TextDrawSetOutline(mesaagetd, 1);
	TextDrawSetShadow(mesaagetd, 0);
	TextDrawAlignment(mesaagetd, 1);
	TextDrawColor(mesaagetd, -1);
	TextDrawBackgroundColor(mesaagetd, 255);
	TextDrawBoxColor(mesaagetd, 50);
	TextDrawUseBox(mesaagetd, 1);
	TextDrawSetProportional(mesaagetd, 1);
	TextDrawSetSelectable(mesaagetd, 1);

	PhoneTD[14] = TextDrawCreate(381.000000, 228.000000, "send message");
	TextDrawFont(PhoneTD[14], 2);
	TextDrawLetterSize(PhoneTD[14], 0.112499, 0.800000);
	TextDrawTextSize(PhoneTD[14], 490.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[14], 1);
	TextDrawSetShadow(PhoneTD[14], 0);
	TextDrawAlignment(PhoneTD[14], 1);
	TextDrawColor(PhoneTD[14], -1);
	TextDrawBackgroundColor(PhoneTD[14], 255);
	TextDrawBoxColor(PhoneTD[14], 50);
	TextDrawUseBox(PhoneTD[14], 0);
	TextDrawSetProportional(PhoneTD[14], 1);
	TextDrawSetSelectable(PhoneTD[14], 0);

	contactstd = TextDrawCreate(455.000000, 208.000000, "HUD:radar_gangy");
	TextDrawFont(contactstd, 4);
	TextDrawLetterSize(contactstd, 0.600000, 2.000000);
	TextDrawTextSize(contactstd, 20.000000, 18.500000);
	TextDrawSetOutline(contactstd, 1);
	TextDrawSetShadow(contactstd, 0);
	TextDrawAlignment(contactstd, 1);
	TextDrawColor(contactstd, -1);
	TextDrawBackgroundColor(contactstd, 255);
	TextDrawBoxColor(contactstd, 50);
	TextDrawUseBox(contactstd, 1);
	TextDrawSetProportional(contactstd, 1);
	TextDrawSetSelectable(contactstd, 1);

	PhoneTD[15] = TextDrawCreate(454.000000, 228.000000, "CONTACTS");
	TextDrawFont(PhoneTD[15], 2);
	TextDrawLetterSize(PhoneTD[15], 0.112499, 0.800000);
	TextDrawTextSize(PhoneTD[15], 490.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[15], 1);
	TextDrawSetShadow(PhoneTD[15], 0);
	TextDrawAlignment(PhoneTD[15], 1);
	TextDrawColor(PhoneTD[15], -1);
	TextDrawBackgroundColor(PhoneTD[15], 255);
	TextDrawBoxColor(PhoneTD[15], 50);
	TextDrawUseBox(PhoneTD[15], 0);
	TextDrawSetProportional(PhoneTD[15], 1);
	TextDrawSetSelectable(PhoneTD[15], 0);

	calltd = TextDrawCreate(455.000000, 269.000000, "HUD:radar_catalinapink");
	TextDrawFont(calltd, 4);
	TextDrawLetterSize(calltd, 0.600000, 2.000000);
	TextDrawTextSize(calltd, 20.000000, 18.500000);
	TextDrawSetOutline(calltd, 1);
	TextDrawSetShadow(calltd, 0);
	TextDrawAlignment(calltd, 1);
	TextDrawColor(calltd, -1);
	TextDrawBackgroundColor(calltd, 255);
	TextDrawBoxColor(calltd, 50);
	TextDrawUseBox(calltd, 1);
	TextDrawSetProportional(calltd, 1);
	TextDrawSetSelectable(calltd, 1);

	PhoneTD[16] = TextDrawCreate(459.000000, 290.000000, "CALL");
	TextDrawFont(PhoneTD[16], 2);
	TextDrawLetterSize(PhoneTD[16], 0.145833, 1.149999);
	TextDrawTextSize(PhoneTD[16], 490.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[16], 1);
	TextDrawSetShadow(PhoneTD[16], 0);
	TextDrawAlignment(PhoneTD[16], 1);
	TextDrawColor(PhoneTD[16], -1);
	TextDrawBackgroundColor(PhoneTD[16], 255);
	TextDrawBoxColor(PhoneTD[16], 50);
	TextDrawUseBox(PhoneTD[16], 0);
	TextDrawSetProportional(PhoneTD[16], 1);
	TextDrawSetSelectable(PhoneTD[16], 0);

	PhoneTD[17] = TextDrawCreate(391.000000, 290.000000, "BANK");
	TextDrawFont(PhoneTD[17], 2);
	TextDrawLetterSize(PhoneTD[17], 0.145833, 1.149999);
	TextDrawTextSize(PhoneTD[17], 490.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[17], 1);
	TextDrawSetShadow(PhoneTD[17], 0);
	TextDrawAlignment(PhoneTD[17], 1);
	TextDrawColor(PhoneTD[17], -1);
	TextDrawBackgroundColor(PhoneTD[17], 255);
	TextDrawBoxColor(PhoneTD[17], 50);
	TextDrawUseBox(PhoneTD[17], 0);
	TextDrawSetProportional(PhoneTD[17], 1);
	TextDrawSetSelectable(PhoneTD[17], 0);

	PhoneTD[18] = TextDrawCreate(457.000000, 340.000000, "MUSIC");
	TextDrawFont(PhoneTD[18], 2);
	TextDrawLetterSize(PhoneTD[18], 0.145833, 1.149999);
	TextDrawTextSize(PhoneTD[18], 490.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[18], 1);
	TextDrawSetShadow(PhoneTD[18], 0);
	TextDrawAlignment(PhoneTD[18], 1);
	TextDrawColor(PhoneTD[18], -1);
	TextDrawBackgroundColor(PhoneTD[18], 255);
	TextDrawBoxColor(PhoneTD[18], 50);
	TextDrawUseBox(PhoneTD[18], 0);
	TextDrawSetProportional(PhoneTD[18], 1);
	TextDrawSetSelectable(PhoneTD[18], 0);

	banktd = TextDrawCreate(389.000000, 269.000000, "HUD:radar_cash");
	TextDrawFont(banktd, 4);
	TextDrawLetterSize(banktd, 0.600000, 2.000000);
	TextDrawTextSize(banktd, 20.000000, 18.500000);
	TextDrawSetOutline(banktd, 1);
	TextDrawSetShadow(banktd, 0);
	TextDrawAlignment(banktd, 1);
	TextDrawColor(banktd, -1);
	TextDrawBackgroundColor(banktd, 255);
	TextDrawBoxColor(banktd, 50);
	TextDrawUseBox(banktd, 1);
	TextDrawSetProportional(banktd, 1);
	TextDrawSetSelectable(banktd, 1);

	musictd = TextDrawCreate(455.000000, 318.000000, "HUD:radar_datedisco");
	TextDrawFont(musictd, 4);
	TextDrawLetterSize(musictd, 0.600000, 2.000000);
	TextDrawTextSize(musictd, 20.000000, 18.500000);
	TextDrawSetOutline(musictd, 1);
	TextDrawSetShadow(musictd, 0);
	TextDrawAlignment(musictd, 1);
	TextDrawColor(musictd, -1);
	TextDrawBackgroundColor(musictd, 255);
	TextDrawBoxColor(musictd, 50);
	TextDrawUseBox(musictd, 1);
	TextDrawSetProportional(musictd, 1);
	TextDrawSetSelectable(musictd, 1);

	twittertd = TextDrawCreate(393.000000, 318.000000, "T");
	TextDrawFont(twittertd, 3);
	TextDrawLetterSize(twittertd, 0.454167, 1.999999);
	TextDrawTextSize(twittertd, 403.500000, 17.000000);
	TextDrawSetOutline(twittertd, 1);
	TextDrawSetShadow(twittertd, 0);
	TextDrawAlignment(twittertd, 1);
	TextDrawColor(twittertd, 16777215);
	TextDrawBackgroundColor(twittertd, -1);
	TextDrawBoxColor(twittertd, 50);
	TextDrawUseBox(twittertd, 0);
	TextDrawSetProportional(twittertd, 1);
	TextDrawSetSelectable(twittertd, 1);

	PhoneAtmTD[0] = TextDrawCreate(319.000000, 178.000000, "_");
	TextDrawFont(PhoneAtmTD[0], 1);
	TextDrawLetterSize(PhoneAtmTD[0], 0.566666, 14.550000);
	TextDrawTextSize(PhoneAtmTD[0], 298.500000, 225.000000);
	TextDrawSetOutline(PhoneAtmTD[0], 1);
	TextDrawSetShadow(PhoneAtmTD[0], 0);
	TextDrawAlignment(PhoneAtmTD[0], 2);
	TextDrawColor(PhoneAtmTD[0], -1);
	TextDrawBackgroundColor(PhoneAtmTD[0], 255);
	TextDrawBoxColor(PhoneAtmTD[0], -16776961);
	TextDrawUseBox(PhoneAtmTD[0], 1);
	TextDrawSetProportional(PhoneAtmTD[0], 1);
	TextDrawSetSelectable(PhoneAtmTD[0], 0);

	PhoneAtmTD[1] = TextDrawCreate(319.000000, 182.000000, "_");
	TextDrawFont(PhoneAtmTD[1], 1);
	TextDrawLetterSize(PhoneAtmTD[1], 0.566666, 13.749997);
	TextDrawTextSize(PhoneAtmTD[1], 298.500000, 225.000000);
	TextDrawSetOutline(PhoneAtmTD[1], 1);
	TextDrawSetShadow(PhoneAtmTD[1], 0);
	TextDrawAlignment(PhoneAtmTD[1], 2);
	TextDrawColor(PhoneAtmTD[1], -1);
	TextDrawBackgroundColor(PhoneAtmTD[1], 255);
	TextDrawBoxColor(PhoneAtmTD[1], 255);
	TextDrawUseBox(PhoneAtmTD[1], 1);
	TextDrawSetProportional(PhoneAtmTD[1], 1);
	TextDrawSetSelectable(PhoneAtmTD[1], 0);

	PhoneAtmTD[2] = TextDrawCreate(245.000000, 226.000000, "_");
	TextDrawFont(PhoneAtmTD[2], 1);
	TextDrawLetterSize(PhoneAtmTD[2], 0.600000, 3.500001);
	TextDrawTextSize(PhoneAtmTD[2], 298.500000, 76.000000);
	TextDrawSetOutline(PhoneAtmTD[2], 1);
	TextDrawSetShadow(PhoneAtmTD[2], 0);
	TextDrawAlignment(PhoneAtmTD[2], 2);
	TextDrawColor(PhoneAtmTD[2], -1);
	TextDrawBackgroundColor(PhoneAtmTD[2], 255);
	TextDrawBoxColor(PhoneAtmTD[2], -1);
	TextDrawUseBox(PhoneAtmTD[2], 1);
	TextDrawSetProportional(PhoneAtmTD[2], 1);
	TextDrawSetSelectable(PhoneAtmTD[2], 0);

	PhoneAtmTD[3] = TextDrawCreate(393.000000, 226.000000, "_");
	TextDrawFont(PhoneAtmTD[3], 1);
	TextDrawLetterSize(PhoneAtmTD[3], 0.600000, 3.500001);
	TextDrawTextSize(PhoneAtmTD[3], 298.500000, 76.000000);
	TextDrawSetOutline(PhoneAtmTD[3], 1);
	TextDrawSetShadow(PhoneAtmTD[3], 0);
	TextDrawAlignment(PhoneAtmTD[3], 2);
	TextDrawColor(PhoneAtmTD[3], -1);
	TextDrawBackgroundColor(PhoneAtmTD[3], 255);
	TextDrawBoxColor(PhoneAtmTD[3], -1);
	TextDrawUseBox(PhoneAtmTD[3], 1);
	TextDrawSetProportional(PhoneAtmTD[3], 1);
	TextDrawSetSelectable(PhoneAtmTD[3], 0);

	PhoneAtmTD[4] = TextDrawCreate(236.000000, 180.000000, "PHL:RP Bank");
	TextDrawFont(PhoneAtmTD[4], 3);
	TextDrawLetterSize(PhoneAtmTD[4], 0.600000, 2.000000);
	TextDrawTextSize(PhoneAtmTD[4], 455.000000, -13.000000);
	TextDrawSetOutline(PhoneAtmTD[4], 1);
	TextDrawSetShadow(PhoneAtmTD[4], 0);
	TextDrawAlignment(PhoneAtmTD[4], 1);
	TextDrawColor(PhoneAtmTD[4], -1);
	TextDrawBackgroundColor(PhoneAtmTD[4], 255);
	TextDrawBoxColor(PhoneAtmTD[4], 50);
	TextDrawUseBox(PhoneAtmTD[4], 0);
	TextDrawSetProportional(PhoneAtmTD[4], 1);
	TextDrawSetSelectable(PhoneAtmTD[4], 0);

	PhoneAtmTransfer = TextDrawCreate(211.000000, 235.000000, "TRANSFER");
	TextDrawFont(PhoneAtmTransfer, 1);
	TextDrawLetterSize(PhoneAtmTransfer, 0.391666, 1.400000);
	TextDrawTextSize(PhoneAtmTransfer, 348.500000, 5.000000);
	TextDrawSetOutline(PhoneAtmTransfer, 1);
	TextDrawSetShadow(PhoneAtmTransfer, 0);
	TextDrawAlignment(PhoneAtmTransfer, 1);
	TextDrawColor(PhoneAtmTransfer, -1);
	TextDrawBackgroundColor(PhoneAtmTransfer, 255);
	TextDrawBoxColor(PhoneAtmTransfer, 50);
	TextDrawUseBox(PhoneAtmTransfer, 0);
	TextDrawSetProportional(PhoneAtmTransfer, 1);
	TextDrawSetSelectable(PhoneAtmTransfer, 1);

	PhoneAtmExit = TextDrawCreate(378.000000, 235.000000, "EXIT");
	TextDrawFont(PhoneAtmExit, 1);
	TextDrawLetterSize(PhoneAtmExit, 0.391666, 1.400000);
	TextDrawTextSize(PhoneAtmExit, 393.500000, 9.500000);
	TextDrawSetOutline(PhoneAtmExit, 1);
	TextDrawSetShadow(PhoneAtmExit, 0);
	TextDrawAlignment(PhoneAtmExit, 1);
	TextDrawColor(PhoneAtmExit, -1);
	TextDrawBackgroundColor(PhoneAtmExit, 255);
	TextDrawBoxColor(PhoneAtmExit, 50);
	TextDrawUseBox(PhoneAtmExit, 0);
	TextDrawSetProportional(PhoneAtmExit, 1);
	TextDrawSetSelectable(PhoneAtmExit, 1);
	
	// ATM TEXTDRAWS
	ATMTD[0] = TextDrawCreate(311.000000, 150.000000, "_");
	TextDrawFont(ATMTD[0], 1);
	TextDrawLetterSize(ATMTD[0], 0.600000, 19.350002);
	TextDrawTextSize(ATMTD[0], 298.500000, 320.500000);
	TextDrawSetOutline(ATMTD[0], 1);
	TextDrawSetShadow(ATMTD[0], 0);
	TextDrawAlignment(ATMTD[0], 2);
	TextDrawColor(ATMTD[0], -1);
	TextDrawBackgroundColor(ATMTD[0], 255);
	TextDrawBoxColor(ATMTD[0], 255);
	TextDrawUseBox(ATMTD[0], 1);
	TextDrawSetProportional(ATMTD[0], 1);
	TextDrawSetSelectable(ATMTD[0], 0);

	ATMTD[1] = TextDrawCreate(311.000000, 156.000000, "_");
	TextDrawFont(ATMTD[1], 1);
	TextDrawLetterSize(ATMTD[1], 0.600000, 17.850002);
	TextDrawTextSize(ATMTD[1], 298.500000, 300.500000);
	TextDrawSetOutline(ATMTD[1], 1);
	TextDrawSetShadow(ATMTD[1], 0);
	TextDrawAlignment(ATMTD[1], 2);
	TextDrawColor(ATMTD[1], -1);
	TextDrawBackgroundColor(ATMTD[1], 255);
	TextDrawBoxColor(ATMTD[1], 1296911871);
	TextDrawUseBox(ATMTD[1], 1);
	TextDrawSetProportional(ATMTD[1], 1);
	TextDrawSetSelectable(ATMTD[1], 0);

	ATMTD[2] = TextDrawCreate(311.000000, 160.000000, "_");
	TextDrawFont(ATMTD[2], 1);
	TextDrawLetterSize(ATMTD[2], 0.600000, 1.750001);
	TextDrawTextSize(ATMTD[2], 298.500000, 303.500000);
	TextDrawSetOutline(ATMTD[2], 1);
	TextDrawSetShadow(ATMTD[2], 0);
	TextDrawAlignment(ATMTD[2], 2);
	TextDrawColor(ATMTD[2], -1);
	TextDrawBackgroundColor(ATMTD[2], 255);
	TextDrawBoxColor(ATMTD[2], 175);
	TextDrawUseBox(ATMTD[2], 1);
	TextDrawSetProportional(ATMTD[2], 1);
	TextDrawSetSelectable(ATMTD[2], 0);

	ATMTD[3] = TextDrawCreate(311.000000, 186.000000, "_");
	TextDrawFont(ATMTD[3], 1);
	TextDrawLetterSize(ATMTD[3], 0.600000, 1.750001);
	TextDrawTextSize(ATMTD[3], 298.500000, 303.500000);
	TextDrawSetOutline(ATMTD[3], 1);
	TextDrawSetShadow(ATMTD[3], 0);
	TextDrawAlignment(ATMTD[3], 2);
	TextDrawColor(ATMTD[3], -1);
	TextDrawBackgroundColor(ATMTD[3], 255);
	TextDrawBoxColor(ATMTD[3], 175);
	TextDrawUseBox(ATMTD[3], 1);
	TextDrawSetProportional(ATMTD[3], 1);
	TextDrawSetSelectable(ATMTD[3], 0);

	ATMTD[4] = TextDrawCreate(164.000000, 227.000000, "ld_pool:ball");
	TextDrawFont(ATMTD[4], 4);
	TextDrawLetterSize(ATMTD[4], 0.600000, 2.000000);
	TextDrawTextSize(ATMTD[4], 77.000000, 87.000000);
	TextDrawSetOutline(ATMTD[4], 1);
	TextDrawSetShadow(ATMTD[4], 0);
	TextDrawAlignment(ATMTD[4], 1);
	TextDrawColor(ATMTD[4], -1);
	TextDrawBackgroundColor(ATMTD[4], 255);
	TextDrawBoxColor(ATMTD[4], 50);
	TextDrawUseBox(ATMTD[4], 0);
	TextDrawSetProportional(ATMTD[4], 1);
	TextDrawSetSelectable(ATMTD[4], 0);

	ATMTD[5] = TextDrawCreate(273.000000, 227.000000, "ld_pool:ball");
	TextDrawFont(ATMTD[5], 4);
	TextDrawLetterSize(ATMTD[5], 0.600000, 2.000000);
	TextDrawTextSize(ATMTD[5], 77.000000, 87.000000);
	TextDrawSetOutline(ATMTD[5], 1);
	TextDrawSetShadow(ATMTD[5], 0);
	TextDrawAlignment(ATMTD[5], 1);
	TextDrawColor(ATMTD[5], -1);
	TextDrawBackgroundColor(ATMTD[5], 255);
	TextDrawBoxColor(ATMTD[5], 50);
	TextDrawUseBox(ATMTD[5], 1);
	TextDrawSetProportional(ATMTD[5], 1);
	TextDrawSetSelectable(ATMTD[5], 0);

	ATMTD[6] = TextDrawCreate(375.000000, 227.000000, "ld_pool:ball");
	TextDrawFont(ATMTD[6], 4);
	TextDrawLetterSize(ATMTD[6], 0.600000, 2.000000);
	TextDrawTextSize(ATMTD[6], 77.000000, 87.000000);
	TextDrawSetOutline(ATMTD[6], 1);
	TextDrawSetShadow(ATMTD[6], 0);
	TextDrawAlignment(ATMTD[6], 1);
	TextDrawColor(ATMTD[6], -1);
	TextDrawBackgroundColor(ATMTD[6], 255);
	TextDrawBoxColor(ATMTD[6], 50);
	TextDrawUseBox(ATMTD[6], 1);
	TextDrawSetProportional(ATMTD[6], 1);
	TextDrawSetSelectable(ATMTD[6], 0);

	withdrawtd = TextDrawCreate(169.000000, 260.000000, "WITHDRAW");
	TextDrawFont(withdrawtd, 1);
	TextDrawLetterSize(withdrawtd, 0.362500, 2.000000);
	TextDrawTextSize(withdrawtd, 242.500000, 32.000000);
	TextDrawSetOutline(withdrawtd, 1);
	TextDrawSetShadow(withdrawtd, 0);
	TextDrawAlignment(withdrawtd, 1);
	TextDrawColor(withdrawtd, -1);
	TextDrawBackgroundColor(withdrawtd, 255);
	TextDrawBoxColor(withdrawtd, 50);
	TextDrawUseBox(withdrawtd, 0);
	TextDrawSetProportional(withdrawtd, 1);
	TextDrawSetSelectable(withdrawtd, 1);

	deposittd = TextDrawCreate(286.000000, 260.000000, "DEPOSIT");
	TextDrawFont(deposittd, 1);
	TextDrawLetterSize(deposittd, 0.362500, 2.000000);
	TextDrawTextSize(deposittd, 338.500000, 122.500000);
	TextDrawSetOutline(deposittd, 1);
	TextDrawSetShadow(deposittd, 0);
	TextDrawAlignment(deposittd, 1);
	TextDrawColor(deposittd, -1);
	TextDrawBackgroundColor(deposittd, 255);
	TextDrawBoxColor(deposittd, 50);
	TextDrawUseBox(deposittd, 0);
	TextDrawSetProportional(deposittd, 1);
	TextDrawSetSelectable(deposittd, 1);

	transfertd = TextDrawCreate(383.000000, 260.000000, "TRANSFER");
	TextDrawFont(transfertd, 1);
	TextDrawLetterSize(transfertd, 0.362500, 2.000000);
	TextDrawTextSize(transfertd, 447.000000, 226.000000);
	TextDrawSetOutline(transfertd, 1);
	TextDrawSetShadow(transfertd, 0);
	TextDrawAlignment(transfertd, 1);
	TextDrawColor(transfertd, -1);
	TextDrawBackgroundColor(transfertd, 255);
	TextDrawBoxColor(transfertd, 50);
	TextDrawUseBox(transfertd, 0);
	TextDrawSetProportional(transfertd, 1);
	TextDrawSetSelectable(transfertd, 1);
==================================================================
CMD:phone(playerid, params[])
{
	if(PlayerInfo[playerid][pTogglePhone])
	{
	    return SCM(playerid, COLOR_SYNTAX, "You can't use your mobile phone right now as you have it toggled ((/tog phone)).");
	}
	if(!PlayerInfo[playerid][pPhone])
	{
	    return SCM(playerid, COLOR_SYNTAX, "You don't have a cellphone and therefore can't use this command.");
	}
    if(PlayerInfo[playerid][pJailTime] > 0) return SendClientMessage(playerid, COLOR_WHITE, "Cannot use this command while in-jail.");
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED || PlayerInfo[playerid][pTazedTime] > 0 || PlayerInfo[playerid][pCuffed] > 0 || PlayerInfo[playerid][pLootTime] > 0)
	    return SCM(playerid, COLOR_GREY, "You're currently unable to use phone at this moment.");

	SendClientMessage(playerid, COLOR_BLUE, "[TIP] {FFFFFF}Press ESC to disable the cursor and use /cursor to get your cursor back active.");

	for(new i = 0; i < 20; i++) {
		TextDrawShowForPlayer(playerid, PhoneTD[i]);
	}
	TextDrawShowForPlayer(playerid, banktd);
	TextDrawShowForPlayer(playerid, mesaagetd);
	TextDrawShowForPlayer(playerid, calltd);
	TextDrawShowForPlayer(playerid, contactstd);
	TextDrawShowForPlayer(playerid, phoneclosetd);
	TextDrawShowForPlayer(playerid, musictd);
	TextDrawShowForPlayer(playerid, twittertd);
	SelectTextDraw(playerid, COLOR_LIGHTBLUE);
	SendProximityMessage(playerid, 20.0, SERVER_COLOR, "**{C2A2DA} %s takes out their phone.", GetRPName(playerid));
	return 1;
}
====================================================================
CMD:hangup(playerid, params[])
{
	if(PlayerInfo[playerid][pCallLine] == INVALID_PLAYER_ID)
	{
	    return SCM(playerid, COLOR_SYNTAX, "You have no calls in session which you can hangup.");
	}
	for(new i = 0; i < 20; i++) {
	TextDrawHideForPlayer(playerid, PhoneTD[i]);
	}
	TextDrawHideForPlayer(playerid, banktd);
	TextDrawHideForPlayer(playerid, mesaagetd);
	TextDrawHideForPlayer(playerid, calltd);
	TextDrawHideForPlayer(playerid, contactstd);
	TextDrawHideForPlayer(playerid, phoneclosetd);
	TextDrawHideForPlayer(playerid, musictd);
	TextDrawHideForPlayer(playerid, twittertd);
	CancelSelectTextDraw(playerid);
	for(new i = 0; i < 13; i ++)
	{
		TextDrawHideForPlayer(playerid, CallingTD[i]);
	}
	for(new g = 0; g < 5; g++) {
		PlayerTextDrawHide(playerid, CallingPlayerTD[playerid][g]);
	}
	TextDrawHideForPlayer(playerid, CloseCallTD);
	TextDrawHideForPlayer(playerid, PICKUP);
	TextDrawHideForPlayer(playerid, HANGUP);
	HangupCall(playerid, HANGUP_USER);
	return 1;
}
=====================================================
    DIALOG_PHONE,
	DIALOG_PHONE_CALL,
	DIALOG_PHONE_SMS,
	DIALOG_PHONE_SMS_TEXT,
	DIALOG_CONTACTS,
	DIALOG_CONTACTS_ADD,
	DIALOG_CONTACTS_NUMBER,
	DIALOG_CONTACTS_OPTIONS,
	DIALOG_ATM_TRANSFER,
	DIALOG_ATM_TRANSFER2,
	DIALOG_ATMDEPOSIT,
	DIALOG_ATMWITHDRAW,
	DIALOG_TWEET,
=====================================================
SEARCH: forward Graffiti_Load();
forward OnPlayerTextContact(playerid);
public OnPlayerTextContact(playerid)
{
	new
		contact[MAX_PLAYER_NAME];

	new rows, fields;
	cache_get_data(rows, fields, connectionID);

	if (!rows)
	{
		return 0;
	}
	else
	{
		new
			number;

		number = cache_get_field_content_int(0, "Number");
		cache_get_field_content(0, "Contact", contact);

		PlayerInfo[playerid][pPhoneSMS] = number;

		ShowPlayerDialog(playerid, DIALOG_PHONE_SMS_TEXT, DIALOG_STYLE_INPUT, "SMS Text", "Please type your message:", "Send", "Cancel");
	}
	return 1;
}

forward OnPlayerListContacts(playerid);
public OnPlayerListContacts(playerid)
{
	new
		contact[MAX_PLAYER_NAME],
		string[1024],
		number;

	new rows, fields;
	cache_get_data(rows, fields, connectionID);
	strcat(string, "Add Contact");

	for (new i = 0; i < rows; i ++)
	{
		cache_get_field_content(i, "contact_name", contact);
		number = cache_get_field_content_int(i, "contact_number");
		format(string, sizeof(string), "%s\n%s (%i)", string, contact, number);

		gListedItems[playerid][i] = cache_get_field_content_int(i, "contact_id");
	}
	ShowPlayerDialog(playerid, DIALOG_CONTACTS, DIALOG_STYLE_LIST, "{FFFFFF}My contacts", string, "Select", "Cancel");
}

ListContacts(playerid)
{
	if (PlayerInfo[playerid][pPhone] > 0)
	{
		mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "SELECT * FROM phone_contacts WHERE phone_number = %i", PlayerInfo[playerid][pPhone]);
		mysql_tquery(connectionID, queryBuffer, "OnPlayerListContacts", "i", playerid);
	}
}

forward OnPhoneBecomeAvailable(playerid);
public OnPhoneBecomeAvailable(playerid)
{
	if(PlayerInfo[playerid][pCallStage] < 1 && PlayerInfo[playerid][pCallLine] != INVALID_PLAYER_ID)
	{
		for(new i = 0; i < 13; i ++)
		{
			TextDrawHideForPlayer(playerid, CallingTD[i]);
		}
		for(new g = 0; g < 5; g++) {
			PlayerTextDrawHide(playerid, CallingPlayerTD[playerid][g]);
		}
		TextDrawHideForPlayer(playerid, CloseCallTD);
		TextDrawHideForPlayer(playerid, PICKUP);
		TextDrawHideForPlayer(playerid, HANGUP);
		SCM(playerid, COLOR_YELLOW, "They didn't answered the call.");
		SCM(playerid, COLOR_GREY, "The other line didn't picked up the call, please try again later.");
		SendProximityMessage(playerid, 20.0, COLOR_GLOBAL, "**{C2A2DA} %s presses a button and hangs up their mobile phone.", GetRPName(playerid));
	} 
	/*else {
		for(new i = 0; i < 13; i ++)
		{
			TextDrawHideForPlayer(playerid, CallingTD[i]);
		}
		for(new g = 0; g < 4; g++) {
			PlayerTextDrawHide(playerid, CallingPlayerTD[playerid][g]);
		}
		TextDrawHideForPlayer(playerid, CloseCallTD);
		TextDrawHideForPlayer(playerid, PICKUP);
		TextDrawHideForPlayer(playerid, HANGUP);
		SCM(playerid, COLOR_YELLOW, "You didn't answered the call, the phone stopped ringing.");
		SendProximityMessage(playerid, 20.0, COLOR_GLOBAL, "**{C2A2DA} %s's phone stopped ringing.", GetRPName(playerid));
	}

	PlayerInfo[playerid][pCallStage] = 0;
	PlayerInfo[playerid][pCallLine] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pCalling] = 0;

	KillTimer(PlayerInfo[playerid][pCallTimer]);*/
	return 1;
}
=============================================
SEARCH: AddToTaxVault(amount)
HangupCall(playerid, reason)
{
	new callerid = PlayerInfo[playerid][pCallLine];

	if(reason == HANGUP_DROPPED)
	{
	    SCM(playerid, COLOR_WHITE, "** The call has been dropped...");
	}
	else
	{
		SendProximityMessage(playerid, 20.0, SERVER_COLOR, "**{C2A2DA} %s presses a button and hangs up their mobile phone.", GetRPName(playerid));
    	SCM(playerid, COLOR_WHITE, "** You hung up your phone and ended the call.");

		if(callerid != playerid)
		{
			CancelSelectTextDraw(callerid);
			for(new i = 0; i < 13; i ++)
			{
				TextDrawHideForPlayer(callerid, CallingTD[i]);
			}
			for(new g = 0; g < 5; g++) {
				PlayerTextDrawHide(callerid, CallingPlayerTD[playerid][g]);
			}
			TextDrawHideForPlayer(callerid, CloseCallTD);
			TextDrawHideForPlayer(callerid, PICKUP);
			TextDrawHideForPlayer(callerid, HANGUP);
			SCM(callerid, COLOR_WHITE, "** They hung up their phone and ended the call.");
		}
	}

	if(callerid != playerid)
	{
		if(GetPlayerSpecialAction(callerid) == SPECIAL_ACTION_USECELLPHONE)
		{
		    SetPlayerSpecialAction(callerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		}

		PlayerInfo[callerid][pCallStage] = 0;
		PlayerInfo[callerid][pCallLine] = INVALID_PLAYER_ID;
	}

	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE)
	{
 		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	}

	PlayerInfo[playerid][pCallStage] = 0;
	PlayerInfo[playerid][pCallLine] = INVALID_PLAYER_ID;
}
============================================================
SEARCH: forward VehicleTimer();
forward HudTimer();
public HudTimer()
{
	foreach(new i : Player)
	{
		new string[128];
		format(string, sizeof(string), "BALANCE; %s", FormatNumber(PlayerInfo[i][pBank]));
		PlayerTextDrawSetString(i, PhoneAtmPlayer[i], string);

	}
}
=====================================================================
SEARCH: case DIALOG_LOCATEPOINTS:
case DIALOG_PHONE:
		{
			if (response)
			{
				switch (listitem)
				{
					case 0:
					{
						ShowPlayerDialog(playerid, DIALOG_PHONE_CALL, DIALOG_STYLE_INPUT, "{6688FF}Call Number", "Please specify the number you would like to call:", "Call", "Cancel");
					}
					case 1:
					{
						ShowPlayerDialog(playerid, DIALOG_PHONE_SMS, DIALOG_STYLE_INPUT, "{6688FF}SMS Number", "Please specify the number you would like to SMS:", "Call", "Cancel");
					}
					case 2:
					{
						ListContacts(playerid);
					}
				}
			}
		}
		case DIALOG_CONTACTS_OPTIONS:
		{
			if (response)
			{
				switch (listitem)
				{
					case 0:
					{
						mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "SELECT contact_name, contact_number FROM phone_contacts WHERE contact_id = %i", PlayerInfo[playerid][pSelected]);
						mysql_tquery(connectionID, queryBuffer, "OnPlayerCallContact", "i", playerid);
					}
					case 1:
					{
						mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "SELECT contact_name, contact_number FROM phone_contacts WHERE contact_id = %i", PlayerInfo[playerid][pSelected]);
						mysql_tquery(connectionID, queryBuffer, "OnPlayerTextContact", "i", playerid);
					}
					case 2:
					{
						mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "DELETE FROM phone_contacts WHERE contact_id = %i", PlayerInfo[playerid][pSelected]);
						mysql_tquery(connectionID, queryBuffer);

						ListContacts(playerid);
						SCM(playerid, COLOR_YELLOW, "You have deleted the selected contact.");
					}
				}
			}
			else
			{
				ListContacts(playerid);
			}
		}
		case DIALOG_CONTACTS_NUMBER:
		{
			if (response)
			{
				new number, string[128];

				if (sscanf(inputtext, "i", number))
				{
					format(string, sizeof(string), "Please input the number for the contact '%s':", gTargetName[playerid]);
					return ShowPlayerDialog(playerid, DIALOG_CONTACTS_NUMBER, DIALOG_STYLE_INPUT, "{FFFFFF}Contact number", string, "Submit", "Cancel");
				}
				else if (number < 1)
				{
					format(string, sizeof(string), "You have entered an invalid number.\n\nPlease input the number for the contact '%s':", gTargetName[playerid]);
					return ShowPlayerDialog(playerid, DIALOG_CONTACTS_NUMBER, DIALOG_STYLE_INPUT, "{FFFFFF}Contact number", string, "Submit", "Cancel");
				}
				else
				{
					mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "INSERT INTO phone_contacts (phone_number, contact_name, contact_number) VALUES(%i, '%e', %i)", PlayerInfo[playerid][pPhone], gTargetName[playerid], number);
					mysql_tquery(connectionID, queryBuffer);

					ListContacts(playerid);
					SCM(playerid, COLOR_YELLOW, "You have added a contact: %s (%i).", gTargetName[playerid], number);
				}
			}
		}
		case DIALOG_CONTACTS_ADD:
		{
			if (response)
			{
				if (isnull(inputtext))
				{
					return ShowPlayerDialog(playerid, DIALOG_CONTACTS_ADD, DIALOG_STYLE_INPUT, "{FFFFFF}Add contact", "Please input the name of the contact to add below:", "Submit", "Cancel");
				}
				else if (strlen(inputtext) > 24)
				{
					return ShowPlayerDialog(playerid, DIALOG_CONTACTS_ADD, DIALOG_STYLE_INPUT, "{FFFFFF}Add contact", "The contact name must be below 24 characters.\n\nPlease input the name of the contact to add below:", "Submit", "Cancel");
				}
				else
				{
					strcpy(gTargetName[playerid], inputtext, MAX_PLAYER_NAME);

					new string[128];
					format(string, sizeof(string), "Please input the number for the contact '%s':", gTargetName[playerid]);
					ShowPlayerDialog(playerid, DIALOG_CONTACTS_NUMBER, DIALOG_STYLE_INPUT, "{FFFFFF}Contact number", string, "Submit", "Cancel");
				}
			}
			else
			{
				ListContacts(playerid);
			}
			return 1;
		}
		case DIALOG_CONTACTS:
		{
			if (response)
			{
				if (listitem == 0)
				{
					ShowPlayerDialog(playerid, DIALOG_CONTACTS_ADD, DIALOG_STYLE_INPUT, "{FFFFFF}Add contact", "Please input the name of the contact to add below:", "Submit", "Cancel");
				}
				else
				{
					PlayerInfo[playerid][pSelected] = gListedItems[playerid][--listitem];

					ShowPlayerDialog(playerid, DIALOG_CONTACTS_OPTIONS, DIALOG_STYLE_LIST, "{FFFFFF}Contact options", "Call contact\nText Message\nDelete contact", "Select", "Cancel");
				}
			}
		}
		case DIALOG_PHONE_SMS_TEXT:
		{
			new text[128];
			new number = PlayerInfo[playerid][pPhoneSMS];

			if (response)
			{
				if (sscanf(inputtext, "s[128]", text))
				{
					ShowPlayerDialog(playerid, DIALOG_PHONE_SMS_TEXT, DIALOG_STYLE_INPUT, "SMS Text", "Please type your message:", "Send", "Cancel");
				}
				else
				{
					foreach(new i : Player)
					{
						if(PlayerInfo[i][pPhone] == number)
						{
							if(PlayerInfo[i][pJailType] > 0)
							{
								return SCM(playerid, COLOR_SYNTAX, "Error:"WHITE" That player is currently imprisoned and cannot use their phone.");
							}
							if(PlayerInfo[i][pTogglePhone])
							{
								return SCM(playerid, COLOR_SYNTAX, "Error:"WHITE" That player has their mobile phone switched off.");
							}

							SendProximityMessage(playerid, 20.0, COLOR_GLOBAL, "**{C2A2DA} %s takes out a cellphone and sends a message.", GetRPName(playerid));

							if(strlen(text) > MAX_SPLIT_LENGTH)
							{
								SCM(i, COLOR_YELLOW, "** [Text from %s] (%i): %.*s... **", GetRPName(playerid), PlayerInfo[playerid][pPhone], MAX_SPLIT_LENGTH, text);
								SCM(i, COLOR_YELLOW, "** [Text from %s] (%i): ...%s **", GetRPName(playerid), PlayerInfo[playerid][pPhone], text[MAX_SPLIT_LENGTH]);

								SCM(playerid, COLOR_RED, "** [Text to %s] (%i): %.*s... **", GetRPName(i), PlayerInfo[i][pPhone], MAX_SPLIT_LENGTH, text);
								SCM(playerid, COLOR_RED, "** [Text to %s] (%i): ...%s **", GetRPName(i), PlayerInfo[i][pPhone], text[MAX_SPLIT_LENGTH]);
							}
							else
							{
								SCM(i, COLOR_YELLOW, "** [Text from %s] (%i): %s **", GetRPName(playerid), PlayerInfo[playerid][pPhone], text);
								SCM(playerid, COLOR_RED, "** [Text to %s] (%i): %s **", GetRPName(i), PlayerInfo[i][pPhone], text);
							}

							/*if(PlayerInfo[i][pTextFrom] == INVALID_PLAYER_ID)
							{
								SCM(i, COLOR_WHITE, "** You can use '/rsms [message]' to reply to this text message.");
							}*/

							PlayerInfo[i][pTextFrom] = playerid;

							return 1;
						}
					}

					mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "SELECT username, jailtype, togglephone FROM users WHERE phone = %i", number);
					mysql_tquery(connectionID, queryBuffer, "OnPlayerSendTextMessage", "iis", playerid, number, text);
				}
			}
		}
		case DIALOG_PHONE_SMS:
		{
			new number;

			if (response)
			{
				if(PlayerInfo[playerid][pTogglePhone])
					return SCM(playerid, COLOR_SYNTAX, "You have your phone toggled.");

				if (sscanf(inputtext, "i", number))
				{
					return ShowPlayerDialog(playerid, DIALOG_PHONE_SMS, DIALOG_STYLE_INPUT, "{6688FF}SMS Number", "Please specify the number you would like to SMS:", "Sms", "Cancel");
				}
				else if (PlayerInfo[playerid][pPhone] == number)
				{
					return ShowPlayerDialog(playerid, DIALOG_PHONE_SMS, DIALOG_STYLE_INPUT, "{6688FF}SMS Number", "You can't text your own number.\n\nPlease specify the number you would like to SMS:", "Sms", "Cancel");
				}
				else if (number < 1)
				{
					return ShowPlayerDialog(playerid, DIALOG_PHONE_SMS, DIALOG_STYLE_INPUT, "{6688FF}SMS Number", "Please specify the number you would like to SMS:", "Sms", "Cancel");
				}
				else
				{
					PlayerInfo[playerid][pPhoneSMS] = number;

					ShowPlayerDialog(playerid, DIALOG_PHONE_SMS_TEXT, DIALOG_STYLE_INPUT, "SMS Text", "Please type your message:", "Send", "Cancel");
				}
			}
		}
=====================================================================
SEARCH: case DIALOG_CREATEQUIZ:
case DIALOG_TWEET:
		{
	    	ShowPlayerDialog(playerid, DIALOG_TWEET, DIALOG_STYLE_INPUT, "Tweet", "What's on your mind?", "Post", "Back");
		}
=====================================================================
=====================================================================
=====================================================================
               PEJU
=====================================================================





