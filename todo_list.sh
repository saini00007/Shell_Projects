#!/bin/bash

# Define the file to store tasks
todo_file="todo.txt"

# Initialize todo file if it doesn't exist
touch "$todo_file"

# Function to add a task
add_task() {
    echo "Enter task:"
    read task
    echo "[ ] $task" >> "$todo_file"
    echo "Task added: $task"
}

# Function to list tasks
list_tasks() {
    if [ -s "$todo_file" ]; then
        cat -n "$todo_file"
    else
        echo "No tasks remaining."
    fi
}

# Function to mark a task as completed
mark_completed() {
    echo "Enter task number to mark as completed:"
    read task_num
    sed -i "${task_num}s/\[ \]/\[x\]/" "$todo_file"
    echo "Task marked as completed: $(sed -n "${task_num}p" "$todo_file")"
}

# Function to clear completed tasks
clear_completed() {
    sed -i '/\[x\]/d' "$todo_file"
    echo "Completed tasks cleared."
}

# Main menu
while true; do
    echo "1. Add Task"
    echo "2. List Tasks"
    echo "3. Mark Task as Completed"
    echo "4. Clear Completed Tasks"
    echo "5. Exit"
    echo "Enter your choice:"
    read choice

    case $choice in
        1) add_task ;;
        2) list_tasks ;;
        3) mark_completed ;;
        4) clear_completed ;;
        5) echo "Exiting..."; exit ;;
        *) echo "Invalid choice. Please enter a number between 1 and 5."
    esac
done

