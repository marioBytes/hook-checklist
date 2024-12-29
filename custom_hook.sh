#!/bin/bash

# Function to get a random encouraging message when canceling
get_encouraging_message() {
    messages=(
        "No worries! Better to catch things early! 💪"
        "Taking your time leads to better code! 🌟"
        "Quality over speed - you've got this! 🚀"
        "Good catch! Future you will thank present you! 🎯"
        "That's the spirit! Clean code is happy code! ✨"
        "Smart move! Take the time you need! 🎨"
        "Excellence takes patience - you're doing great! 🌈",
	"Another encouraging messge!"
    )
    random_index=$((RANDOM % ${#messages[@]}))
    echo "${messages[$random_index]}"
}

# Function to get a random success message
get_success_message() {
    messages=(
        "Awesome work completing your checklist! 🎉"
        "Look at you, being all professional! 🌟"
        "Your attention to detail is amazing! 💫"
        "Great job following best practices! 🏆"
        "Your future self will thank you! 🙌"
        "Now that's how it's done! 🚀"
        "You're making the codebase better! ⭐"
    )
    random_index=$((RANDOM % ${#messages[@]}))
    echo "${messages[$random_index]}"
}

# Display prompt
echo -e "\n=== Before Pushing ==="
echo "🔍 Have you completed your pre-push checklist?"
echo "   • Reviewed all changes"
echo "   • Tested your code"
echo "   • Updated documentation"
echo "   • Removed debug statements"

# Get user input
while true; do
    read -p $'\nReady to push? (y/n): ' response </dev/tty
    case $response in
        [Yy]* )
            success_msg=$(get_success_message)
            echo -e "\n✅ $success_msg"
            echo "🚀 Proceeding with push..."
            exit 0
            ;;
        [Nn]* )
            encourage_msg=$(get_encouraging_message)
            echo -e "\n❌ Push cancelled. $encourage_msg"
            echo "📝 Take your time to review and try again when ready!"
            exit 1
            ;;
        * )
            echo "Please enter 'y' or 'n'"
            ;;
    esac
done

exit 0
