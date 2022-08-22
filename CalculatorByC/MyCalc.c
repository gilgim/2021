//=====================================================================================================================
// <참조 정보>
//=====================================================================================================================
// 알고리즘 참조 - https://jamanbbo.tistory.com/53
//=====================================================================================================================
// <함수 헤더 선언>
//=====================================================================================================================
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <malloc.h>
//#include <windows.h>
//#include "Calc.h"
//=====================================================================================================================
// <개발자 함수 헤더 정의>
//=====================================================================================================================
void ClearScreen(void);
void WaitProgram(void);
void InputCalcExp(char* crInfixExp);
void MemoryAlloc(char** mBuffer, int nBufferIndex, size_t nMemorySize);
void PushOpStack(char* cpOpStack, char cOp, int* npOpStackCurIndex);
char PopOpStack(char* cpOpStack, int* npOpStackCurIndex);
void PushCalcStack(double* npCalcStack, double nValue, int* npCalcStackIndex);
double PopCalcStack(double* npCalcStack, int* npCalcStackIndex);
void CopyOpToPostfixExp(int* npPostfixCurIndex, char cOp);
void ProcessOp(int* npPostfixCurIndex, char* cpOpStack, int* npOpStackCurIndex, char cOp);
void ParsingInfixExp(char* cpInfixExp);
void ParsingInfixToPostfixExp(void);
int Calc(double* npCalcResult);
void PrintResult(char* cpInfixExp, double nCalcResult);
void PrintMessage(char* cpTitle, char* cpMessage);
void FreeMemory(void);
void ExitProgram(char* cpTitle, char* cpMessage);
//=====================================================================================================================
// <개발자 상수 정의>
//=====================================================================================================================
#define MAX_LEN					1024
#define null					'\0'
#define TRUE					1
#define FALSE					0
#define DEF_EXP1				"3+4*5"
#define DEF_EXP2				"(3+4)*(5+6)"
#define DEF_EXP3				"(12+234)*(3567+45678)*(90-100)-10*20"
#define DEF_EXP4				"10*20-(30/40+(50-60))"
#define DEF_EXP5				"(2*(3+6/2)+2)/4+3*4-5/6-/"
#define DEF_EXP6				""

#define EXIT_TITLE				"프로그램 종료"
#define ERROR_TITLE				"오류 발생"

#define PROG_EXIT				"프로그램이 정상 종료 되었습니다."
#define INSUFFICIENT_MEMORY		"메모리가 부족하여 프로그램을 종료 합니다."
#define INVALIDED_EXPRESSION	"수식이 잘못 되었습니다."
//=====================================================================================================================
// <개발자 전역 변수 정의>
//=====================================================================================================================
char* cprParsedInfixExp[MAX_LEN];						//문자열 수식을 중위식으로 파징한 문자열 배열(2차원 배열)
char* cprParsedPostfixExp[MAX_LEN];						//중위식 수식을 후위식으로 파징한 문자열 배열(2차원 배열)
//=====================================================================================================================
// <메인 함수 정의>
//=====================================================================================================================
///-------------------------------------------------------------------------------------------
/// <summary>
/// 메인 함수
/// </summary>
/// <param name="">void</param>
///-------------------------------------------------------------------------------------------
void main(void)
{
	char crInfixExp[MAX_LEN];							//중위식으로 입력된 수식 문자열
	double nCalcResult = 0;								//최종 계산 결과 저장

	while (1)											//무한루프
	{
		InputCalcExp(crInfixExp);						//계산 할 수식 입력 받기

		ParsingInfixExp(crInfixExp);					//중위식으로 변환(수식 문자열 -> 중위식)
		ParsingInfixToPostfixExp();						//후위식으로 변환(중위식 -> 후위식)
		
		if (Calc(&nCalcResult) == TRUE)					//후위식을 사용하여 최종 계산
		{
			PrintResult(crInfixExp, nCalcResult);		//결과 출력
		}

		FreeMemory();									//메모리 해제(중위식, 후위식 배열 메모리 해제)
		WaitProgram();									//일시 정지
	}
}
//=====================================================================================================================
// <개발자 함수 정의>
//=====================================================================================================================
///-------------------------------------------------------------------------------------------
/// <summary>
/// 콘솔 창 지우기
/// </summary>
/// <param name="">void</param>
///-------------------------------------------------------------------------------------------
//void ClearScreen(void)
//{
//	system("cls");
//}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 프로그램 일시 정지
/// </summary>
/// <param name="">void</param>
///-------------------------------------------------------------------------------------------
void WaitProgram(void)
{
	int cDummy = 0;

	printf("Press any key to continue...");

	cDummy = getchar();
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 키보드에서 계산 할 수식 입력받기
/// </summary>
/// <param name="crInfixExp">입력된 수식 문자열을 저장 할 포인터</param>
///-------------------------------------------------------------------------------------------
void InputCalcExp(char* crInfixExp)
{
	//ClearScreen();

	printf("===========================================================\n");
	printf(" [ 계산기 프로그램 ]\n");
	printf("-----------------------------------------------------------\n");
	printf(" 0. 프로그램 종료\n");
	printf(" 1. 기본식 -> %s\n", DEF_EXP1);
	printf(" 2. 일반식 -> %s\n", DEF_EXP2);
	printf(" 3. 일반식 -> %s\n", DEF_EXP3);
	printf(" 4. 일반식 -> %s\n", DEF_EXP4);
	printf(" 5. 오류식 -> %s\n", DEF_EXP5);
	printf(" 6. 없는식 -> %s\n", DEF_EXP6);
	printf("-----------------------------------------------------------\n");
	printf(" 계산 할 수식을 입력하세요 [Enter:%s]\n", DEF_EXP1);
	printf("===========================================================\n");
	printf(" ===>>> ");
	gets_s(crInfixExp, MAX_LEN);											// 수식 입력 받기

	if (strlen(crInfixExp) == 0)
	{
		strcpy_s(crInfixExp, MAX_LEN, DEF_EXP1);
		printf(" %s\n", crInfixExp);
	}
	else if (strlen(crInfixExp) == 1)
	{
		if (strcmp(crInfixExp, "0") == 0) ExitProgram(EXIT_TITLE, PROG_EXIT);
		else if(strcmp(crInfixExp, "1") == 0) strcpy_s(crInfixExp, MAX_LEN, DEF_EXP1);
		else if (strcmp(crInfixExp, "2") == 0) strcpy_s(crInfixExp, MAX_LEN, DEF_EXP2);
		else if (strcmp(crInfixExp, "3") == 0) strcpy_s(crInfixExp, MAX_LEN, DEF_EXP3);
		else if (strcmp(crInfixExp, "4") == 0) strcpy_s(crInfixExp, MAX_LEN, DEF_EXP4);
		else if (strcmp(crInfixExp, "5") == 0) strcpy_s(crInfixExp, MAX_LEN, DEF_EXP5);
	}
	printf("=================================================\n\n");
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 메모리 할당
/// </summary>
/// <param name="cppBuffer">메모리를 할당 할 2차원 배열 포인터</param>
/// <param name="nBufferIndex">2차원 배열 포인터 행 위치</param>
/// <param name="nMemorySize">할당 할 메모리 크기</param>
///-------------------------------------------------------------------------------------------
void MemoryAlloc(char** cppBuffer, int nBufferIndex, size_t nMemorySize)
{
	cppBuffer[nBufferIndex] = (char*)malloc(nMemorySize);				//메모리 할당

	if (cppBuffer[nBufferIndex] == NULL)
	{
		ExitProgram(ERROR_TITLE, INSUFFICIENT_MEMORY);
	}
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 연산자 스택에 내용을 추가하고 인덱스 계산
/// </summary>
/// <param name="cpOpStack">연산자 스택 배열 포인터</param>
/// <param name="cOp">추가 할 연산자</param>
/// <param name="npOpStackCurIndex">연산자 스택 인덱스 포인터</param>
///-------------------------------------------------------------------------------------------
void PushOpStack(char* cpOpStack, char cOp, int* npOpStackCurIndex)
{
	cpOpStack[*npOpStackCurIndex] = cOp;							//Push
	*npOpStackCurIndex = *npOpStackCurIndex + 1;					//Calc Index
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 연산자 스택에서 내용을 반환 및 제거하고 인덱스 계산
/// </summary>
/// <param name="cpOpStack">연산자 스택 배열 포인터</param>
/// <param name="npOpStackCurIndex">연산자 스택 인덱스 포인터</param>
///-------------------------------------------------------------------------------------------
char PopOpStack(char* cpOpStack, int* npOpStackCurIndex)
{
	char cData;

	cData = cpOpStack[*npOpStackCurIndex - 1];					//Pop

	cpOpStack[*npOpStackCurIndex - 1] = null;					//Delete
	*npOpStackCurIndex = *npOpStackCurIndex - 1;				//Calc Index

	return cData;
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 계산용 스택에 내용을 추가하고 인덱스 계산
/// </summary>
/// <param name="npCalcStack">계산용 스택 배열 포인터</param>
/// <param name="nValue">추가 숫자</param>
/// <param name="npCalcStackIndex">계산용 스택 인덱스 포인터</param>
///-------------------------------------------------------------------------------------------
void PushCalcStack(double* npCalcStack, double nValue, int* npCalcStackIndex)
{
	npCalcStack[*npCalcStackIndex] = nValue;					//Push
	*npCalcStackIndex = *npCalcStackIndex + 1;					//Calc Index
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 계산용 스택에서 내용을 반환 및 제거하고 인덱스 계산
/// </summary>
/// <param name="npCalcStack">계산용 스택 배열 포인터</param>
/// <param name="npCalcStackIndex">계산용 스택 인덱스 포인터</param>
///-------------------------------------------------------------------------------------------
double PopCalcStack(double* npCalcStack, int* npCalcStackIndex)
{
	double nValue = 0;

	nValue = npCalcStack[*npCalcStackIndex - 1];				//계산 할 숫자 읽기

	npCalcStack[*npCalcStackIndex - 1] = 0;						//Delete
	*npCalcStackIndex = *npCalcStackIndex - 1;					//Calc Index

	return nValue;
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 후위식 배열에 연산자 스택의 연산자를 읽어서 복사
/// </summary>
/// <param name="npPostfixCurIndex">후위식 배열 인덱스</param>
/// <param name="crOpStack">연산자 스택 포인터</param>
/// <param name="nOpStackCurIndex">연산자 스택 인덱스</param>
///-------------------------------------------------------------------------------------------
void CopyOpToPostfixExp(int* npPostfixCurIndex, char cOp)
{
	cprParsedPostfixExp[*npPostfixCurIndex][0] = cOp;			//Copy Op
	cprParsedPostfixExp[*npPostfixCurIndex][1] = null;			//Copy null

	*npPostfixCurIndex = *npPostfixCurIndex + 1;				//Calc PostfixExp Index
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 연산자 스택의 연산자가 현재의 연산자 보다 크거나 같은 경우 처리
/// </summary>
/// <param name="npPostfixCurIndex">후위식 배열 인덱스</param>
/// <param name="cpOpStack">연산자 스택 포인터</param>
/// <param name="npOpStackCurIndex">연산자 스택 인덱스</param>
/// <param name="cOp">연산자 스택에 Push 할 현재 연산자</param>
///-------------------------------------------------------------------------------------------
void ProcessOp(int* npPostfixCurIndex, char* cpOpStack, int* npOpStackCurIndex, char cOp)
{
	size_t nMemSize = 0;															//메모리 할당 크기

	nMemSize = sizeof(char) * (1 + 1);												//메모리 할당 크기 계산(연산자길이 + NULL길이)
	MemoryAlloc(cprParsedPostfixExp, *npPostfixCurIndex, nMemSize);					//메모리 할당
	CopyOpToPostfixExp(npPostfixCurIndex, PopOpStack(cpOpStack, npOpStackCurIndex));//연산자를 후위식 배열에 복사
	PushOpStack(cpOpStack, cOp, npOpStackCurIndex);									//Push Stack
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 중위식으로 입력된 수식 문자열을 파징하여 문자타입 2차원 배열에 저장(문자열의 1차원 배열)
/// </summary>
/// <param name="cpInfixExp">중위식으로 입력된 수식 문자열 포인터</param>
/// <returns>void</returns>
///-------------------------------------------------------------------------------------------
void ParsingInfixExp(char* cpInfixExp)
{
	int nInfixExpCurIndex = 0;
	char* cpNumStart = null;								//숫자 시작 위치
	int nNumLength = 0;										//숫자 길이
	size_t nMemSize = 0;									//메모리 할당 크기

	for (; *cpInfixExp != null; cpInfixExp++)
	{
		//----------------------------------------------------------------------------
		//연산자인 경우
		//----------------------------------------------------------------------------
		if (isdigit(*cpInfixExp) == FALSE)
		{
			//----------------------------------------------------------------------------
			//파징한 숫자가 있는 경우 먼저 저장
			//----------------------------------------------------------------------------
			if (cpNumStart != NULL)
			{
				nMemSize = sizeof(char) * (nNumLength + 1);						//메모리 할당 크기 계산(숫자길이 + NULL길이)
				MemoryAlloc(cprParsedInfixExp, nInfixExpCurIndex, nMemSize);	//메모리 할당

				strncpy_s(cprParsedInfixExp[nInfixExpCurIndex], nMemSize, cpNumStart, nNumLength);	//파징한 숫자 복사(NULL 자동 추가됨)

				cpNumStart = null;												//숫자 시작 위치
				nNumLength = 0;
				nInfixExpCurIndex = nInfixExpCurIndex + 1;						//수식 항목 위치 증가
			}
			//----------------------------------------------------------------------------
			//파징한 연산자를 저장
			//----------------------------------------------------------------------------
			nMemSize = sizeof(char) * (1 + 1);									//메모리 할당 크기 계산(연산자길이 + NULL길이)
			MemoryAlloc(cprParsedInfixExp, nInfixExpCurIndex, nMemSize);		//메모리 할당

			cprParsedInfixExp[nInfixExpCurIndex][0] = *cpInfixExp;				//연산자 저장
			cprParsedInfixExp[nInfixExpCurIndex][1] = null;						//문자열 끝

			nInfixExpCurIndex = nInfixExpCurIndex + 1;							//수식 항목 위치 증가
		}
		//----------------------------------------------------------------------------
		//숫자인 경우
		//----------------------------------------------------------------------------
		else
		{
			if (cpNumStart == NULL) cpNumStart = cpInfixExp;					//숫자 시작 위치 저장(다음 숫자 파징까지 고정)

			nNumLength = nNumLength + 1;										//숫자 길이 증가
		}
	}
	//----------------------------------------------------------------------------
	//마지막 파징한 숫자가 남아 있는 경우 중위식 배열에 복사
	//----------------------------------------------------------------------------
	if (cpNumStart != null)
	{
		nMemSize = sizeof(char) * (nNumLength + 1);								//메모리 할당 크기 계산(숫자길이 + NULL길이)
		MemoryAlloc(cprParsedInfixExp, nInfixExpCurIndex, nMemSize);			//메모리 할당

		strncpy_s(cprParsedInfixExp[nInfixExpCurIndex], nMemSize, cpNumStart, nNumLength);	//파징한 숫자 복사(NULL 자동 추가됨)

		cpNumStart = null;														//숫자 시작 위치
		nNumLength = 0;
		nInfixExpCurIndex = nInfixExpCurIndex + 1;								//수식 항목 위치 증가
	}
	//----------------------------------------------------------------------------
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 중위식으로 입력된 수식 문자열을 파징하여 후위식으로 변환
/// </summary>
/// <returns>void</returns>
///-------------------------------------------------------------------------------------------
void ParsingInfixToPostfixExp(void)
{
	char crOpStack[MAX_LEN] = { null, };					//중위식을 후위식으로 변경시 사용 할 연산자 스택
	int nOpStackCurIndex = 0;								//연산자 스택의 인덱스(0 이면 스택 Empty)
	int nPostfixCurIndex = 0;								//후위식 배열의 인덱스
	size_t nMemSize = 0;									//메모리 할당 크기

	for (int nIndex = 0; cprParsedInfixExp[nIndex] != null; nIndex++)
	{
		//----------------------------------------------------------------------------
		//연산자인 경우(첫 문자만 숫자인지 확인)
		//----------------------------------------------------------------------------
		if (isdigit(*cprParsedInfixExp[nIndex]) == FALSE)
		{
			switch (*cprParsedInfixExp[nIndex])
			{
				case '(':
					PushOpStack(crOpStack, '(', &nOpStackCurIndex);									//Push Stack
					break;
				case ')':
					if (nOpStackCurIndex > 0)
					{
						while (crOpStack[nOpStackCurIndex - 1] != '(')
						{
							nMemSize = sizeof(char) * (1 + 1);												//메모리 할당 크기 계산(연산자길이 + NULL길이)
							MemoryAlloc(cprParsedPostfixExp, nPostfixCurIndex, nMemSize);					//메모리 할당
							CopyOpToPostfixExp(&nPostfixCurIndex, PopOpStack(crOpStack, &nOpStackCurIndex));//연산자를 후위식 배열에 복사
						}

						PopOpStack(crOpStack, &nOpStackCurIndex);											//Pop Stack (')' 제거)
					}
					break;
				case '+':
					if (nOpStackCurIndex == 0) PushOpStack(crOpStack, '+', &nOpStackCurIndex);		//Push Stack
					else
					{
						if (crOpStack[nOpStackCurIndex - 1] == '+' || crOpStack[nOpStackCurIndex - 1] == '-' || crOpStack[nOpStackCurIndex - 1] == '*' || crOpStack[nOpStackCurIndex - 1] == '/')
							ProcessOp(&nPostfixCurIndex, crOpStack, &nOpStackCurIndex, '+');
						else
							PushOpStack(crOpStack, '+', &nOpStackCurIndex);							//Push Stack
					}
					break;
				case '-':
					if (nOpStackCurIndex == 0) PushOpStack(crOpStack, '-', &nOpStackCurIndex);		//Push Stack
					else
					{
						if (crOpStack[nOpStackCurIndex - 1] == '+' || crOpStack[nOpStackCurIndex - 1] == '-' || crOpStack[nOpStackCurIndex - 1] == '*' || crOpStack[nOpStackCurIndex - 1] == '/')
							ProcessOp(&nPostfixCurIndex, crOpStack, &nOpStackCurIndex, '-');
						else
							PushOpStack(crOpStack, '-', &nOpStackCurIndex);							//Push Stack
					}
					break;
				case '*':
					if (nOpStackCurIndex == 0) PushOpStack(crOpStack, '*', &nOpStackCurIndex);		//Push Stack
					else
					{
						if (crOpStack[nOpStackCurIndex - 1] == '*' || crOpStack[nOpStackCurIndex - 1] == '/')
							ProcessOp(&nPostfixCurIndex, crOpStack, &nOpStackCurIndex, '*');
						else
							PushOpStack(crOpStack, '*', &nOpStackCurIndex);							//Push Stack
					}
					break;
				case '/':
					if (nOpStackCurIndex == 0) PushOpStack(crOpStack, '/', &nOpStackCurIndex);		//Push Stack
					else
					{
						if (crOpStack[nOpStackCurIndex - 1] == '*' || crOpStack[nOpStackCurIndex - 1] == '/')
							ProcessOp(&nPostfixCurIndex, crOpStack, &nOpStackCurIndex, '/');
						else
							PushOpStack(crOpStack, '/', &nOpStackCurIndex);							//Push Stack
					}
					break;
			}
		}
		//----------------------------------------------------------------------------
		//숫자인 경우 후위식 배열에 숫자 복사
		//----------------------------------------------------------------------------
		else
		{
			nMemSize = sizeof(char) * (strlen(cprParsedInfixExp[nIndex]) + 1);						//메모리 할당 크기 계산(숫자길이 + NULL길이)
			MemoryAlloc(cprParsedPostfixExp, nPostfixCurIndex, nMemSize);							//메모리 할당

			strcpy_s(cprParsedPostfixExp[nPostfixCurIndex], nMemSize, cprParsedInfixExp[nIndex]);	//파징한 숫자 복사(NULL 자동 추가됨)

			nPostfixCurIndex = nPostfixCurIndex + 1;
		}
	}
	//----------------------------------------------------------------------------
	//연산자 스택이 비어있지 않은 경우 스택내의 모든 연산자를 후위식 뒤에 복사
	//----------------------------------------------------------------------------
	if (nOpStackCurIndex > 0)
	{
		while(nOpStackCurIndex > 0 && crOpStack[nOpStackCurIndex - 1] != null)
		{
			nMemSize = sizeof(char) * (1 + 1);														//메모리 할당 크기 계산(연산자길이 + NULL길이)
			MemoryAlloc(cprParsedPostfixExp, nPostfixCurIndex, nMemSize);							//메모리 할당
			CopyOpToPostfixExp(&nPostfixCurIndex, PopOpStack(crOpStack, &nOpStackCurIndex));		//연산자를 후위식 배열에 복사
		}
	}
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 후위식으로 파징된 수식 항목을 사용하여 최종 계산
/// </summary>
/// <param name="nCalcResult">최종 계산 결과 포인터</param>
/// <returns>최종계산결과</returns>
///-------------------------------------------------------------------------------------------
int Calc(double* npCalcResult)
{
	double nrCalcStack[MAX_LEN] = { 0, };											//후위식을 사용하여 계산에 사용되는 스택
	int nrCalcStackIndex = 0;														//스택 인텍스(마지막 저장 위치)
	double nNum1 = 0;
	double nNum2 = 0;
	int nResult = TRUE;

	for (int nIndex = 0; cprParsedPostfixExp[nIndex] != null; nIndex++)
	{
		if (isdigit(*cprParsedPostfixExp[nIndex]) == FALSE)
		{
			if (nrCalcStackIndex - 2 >= 0)
			{
				nNum2 = PopCalcStack(nrCalcStack, &nrCalcStackIndex);					//스택에서 값 읽기
				nNum1 = PopCalcStack(nrCalcStack, &nrCalcStackIndex);					//스택에서 값 읽기


				switch (*cprParsedPostfixExp[nIndex])
				{
					case '+':
						PushCalcStack(nrCalcStack, nNum1 + nNum2, &nrCalcStackIndex);	//Push
						break;
					case '-':
						PushCalcStack(nrCalcStack, nNum1 - nNum2, &nrCalcStackIndex);	//Push
						break;
					case '*':
						PushCalcStack(nrCalcStack, nNum1 * nNum2, &nrCalcStackIndex);	//Push
						break;
					case '/':
						PushCalcStack(nrCalcStack, nNum1 / nNum2, &nrCalcStackIndex);	//Push
						break;
				}
			}
			else
			{
				nResult = FALSE;

				PrintMessage(ERROR_TITLE, INVALIDED_EXPRESSION);
				break;
			}
		}
		else
		{
			PushCalcStack(nrCalcStack, atof(cprParsedPostfixExp[nIndex]), &nrCalcStackIndex);	//Push
		}
	}

	if (nResult == TRUE)
	{
		*npCalcResult = nrCalcStack[0];		//최종 계산 결과 저장
	}

	return nResult;
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 중위식 & 후위식 & 연산식 & 결과 출력
/// </summary>
/// <param name="cpInfixExp">중위식으로 입력된 수식 문자열 포인터</param>
/// <param name="nCalcResult">최종계산결과</param>
/// <returns>void</returns>
///-------------------------------------------------------------------------------------------
void PrintResult(char* cpInfixExp, double nCalcResult)
{
	//----------------------------------------------------------------------------
	//입력한 중위식 화면 출력
	//----------------------------------------------------------------------------
	printf("-------------------------------------------------\n");
	printf(" [1] 입력한 중위식\n");
	printf("-------------------------------------------------\n");
	printf("입력식 : crInfixExp -> %s\n", cpInfixExp);
	//----------------------------------------------------------------------------
	//중위식 화면 출력
	//----------------------------------------------------------------------------
	printf("-------------------------------------------------\n");
	printf(" [2] 파징한 중위식\n");
	printf("-------------------------------------------------\n");
	for (int nIndex = 0; cprParsedInfixExp[nIndex] != null; nIndex++)
	{
		printf("중위식 : cprParsedInfixExp[%d] -> %s, %d\n", nIndex, cprParsedInfixExp[nIndex], _msize(cprParsedInfixExp[nIndex]));
	}
	printf("-------------------------------------------------\n");
	printf(" [3] 파징한 후위식\n");
	printf("-------------------------------------------------\n");
	//----------------------------------------------------------------------------
	//후위식 화면 출력
	//----------------------------------------------------------------------------
	for (int nIndex = 0; cprParsedPostfixExp[nIndex] != null; nIndex++)
	{
		printf("후위식 : cprParsedPostfixExp[%d] -> %s, %d\n", nIndex, cprParsedPostfixExp[nIndex], _msize(cprParsedPostfixExp[nIndex]));
	}
	printf("-------------------------------------------------\n");
	printf(" [4] 결과\n");
	printf("-------------------------------------------------\n");
	//----------------------------------------------------------------------------
	//결과 화면 출력
	//----------------------------------------------------------------------------
	printf("입력식 : crInfixExp -> %s\n", cpInfixExp);
	printf("결  과 : Calc -> %f\n", nCalcResult);
	//----------------------------------------------------------------------------
	printf("-------------------------------------------------\n\n\n");
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 메시지 출력
/// </summary>
/// <param name="cpTitle">출력 할 메시지 타이틀</param>
/// <param name="cpMessage">출력 할 메시지</param>
///-------------------------------------------------------------------------------------------
void PrintMessage(char* cpTitle, char* cpMessage)
{
	printf("\n");
	printf("#################################################\n");
	printf(" [%s]\n", cpTitle);
	printf("-------------------------------------------------\n");
	printf(" %s\n", cpMessage);
	printf("#################################################\n");
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 메모리 해제
/// </summary>
/// <param name="">void</param>
///-------------------------------------------------------------------------------------------
void FreeMemory(void)
{
	//----------------------------------------------------------------------------
	//cprParsedInfixExp 메모리 해제
	//----------------------------------------------------------------------------
	for (int nIndex = 0; cprParsedInfixExp[nIndex] != null; nIndex++)
	{
		free(cprParsedInfixExp[nIndex]);

		cprParsedInfixExp[nIndex] = null;		//해제한 메모리는 반드시 null 처리
	}
	//----------------------------------------------------------------------------
	//cprParsedPostfixExp 메모리 해제
	//----------------------------------------------------------------------------
	for (int nIndex = 0; cprParsedPostfixExp[nIndex] != null; nIndex++)
	{
		free(cprParsedPostfixExp[nIndex]);

		cprParsedPostfixExp[nIndex] = null;		//해제한 메모리는 반드시 null 처리
	}
}
///-------------------------------------------------------------------------------------------
/// <summary>
/// 파징된 문자타입의 2차원 배열에 할당된 메모리 해제(메모리 Leak(누수) 방지)
/// </summary>
/// <param name="cpTitle">출력 할 메시지 타이틀</param>
/// <param name="cpMessage">출력 할 메시지</param>
///-------------------------------------------------------------------------------------------
void ExitProgram(char* cpTitle, char* cpMessage)
{
	FreeMemory();						//메모리 해제

	PrintMessage(cpTitle, cpMessage);
	//printf("\n<<<%s>>>\n", crMessage);

	exit(0);
}
//=====================================================================================================================
// <END>
//=====================================================================================================================
