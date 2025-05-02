from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

app = FastAPI()

class Task(BaseModel):
    title: str
    completed: bool = False

class TaskOut(Task):
    id: int

tasks = []
task_id_counter = 1

@app.get("/tasks", response_model=List[TaskOut])
def get_tasks():
    return tasks

@app.post("/tasks", response_model=TaskOut)
def add_task(task: Task):
    global task_id_counter
    new_task = {"id": task_id_counter, "title": task.title, "completed": task.completed}
    tasks.append(new_task)
    task_id_counter += 1
    return new_task

@app.delete("/tasks/{task_id}")
def delete_task(task_id: int):
    global tasks
    tasks = [t for t in tasks if t["id"] != task_id]
    return {"message": "Task deleted"}

@app.get("/")
def read_root():
    return {"message": "Welcome to the Cloud Task Manager!"}
