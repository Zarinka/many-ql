package question

import "fmt"

// Parser interface describes the interface between the application and human beings.
type Parser interface {
	FromString(str string) error
	fmt.Stringer
}

// Question models the structure of one question within a Questionaire.
type Question struct {
	Label string

	// todo(carlos) convert this to interface which represents the behavior common to all questions
	Content interface{}
}
