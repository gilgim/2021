//=====================================================================================================================
// <함수 헤더 선언>
//=====================================================================================================================
#include <stdio.h>
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
#define MAX_LEN				1024
#define null					'\0'
#define TRUE					1
#define FALSE				0
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
// <END>
//=====================================================================================================================
