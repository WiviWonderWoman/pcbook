package service

import (
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

// User contains user's information
type User struct {
	Username       string
	Hashedpassword string
	Role           string
}

// NewUser returns a new user
func NewUser(username string, password string, role string) (*User, error) {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return nil, fmt.Errorf("cannot hash password: %w", err)
	}

	user := &User{
		Username:       username,
		Hashedpassword: string(hashedPassword),
		Role:           role,
	}

	return user, nil
}

// IsCorrectPassword checks if the password is correct or not
func (user *User) IsCorrectPassword(password string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(user.Hashedpassword), []byte(password))
	return err == nil
}

func (user *User) Clone() *User {
	return &User{
		Username:       user.Username,
		Hashedpassword: user.Hashedpassword,
		Role:           user.Role,
	}
}
