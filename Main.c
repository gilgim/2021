///=====================================================================================================================
/// <참조 정보>
///=====================================================================================================================
// 알고리즘 참조 - https://jamanbbo.tistory.com/53
///=====================================================================================================================
/// <함수 헤더 선언>
///=====================================================================================================================
#include "Calc.h"
///=====================================================================================================================
/// <메인 함수 정의>
///=====================================================================================================================
///-------------------------------------------------------------------------------------------
/// <summary>
/// 메인 함수
/// </summary>
/// <param name="">없음</param>
///-------------------------------------------------------------------------------------------
void main(void)
{
	char crInfixExp[MAX_LEN];							//중위식으로 입력된 수식 문자열
	double nCalcResult = 0;								//최종 계산 결과 저장

	while (1)											    //무한루프
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
///=====================================================================================================================
/// <END>
///=====================================================================================================================
