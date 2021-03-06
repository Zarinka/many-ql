package question

import "testing"

func testBoolQuestion(t *testing.T, input, output string) {
	aBoolQuestion := new(BoolQuestion)
	aBoolQuestion.FromString(input)

	if got := aBoolQuestion.String(); output != got {
		t.Errorf("Internal error in BoolQuestion. Got %s, Expected %s", got, output)
	}
}

func TestBoolQuestion(t *testing.T) {
	testBoolQuestion(t, "1", "Yes")
	testBoolQuestion(t, "0", "No")
}
