# Case Studies



```python
import paktum as pkm

# 创建族群
law1 = pkm.Pactum("A robot may not injure a human being or, through inaction, allow a human being to come to harm.", tag="Laws")
law2 = pkm.Pactum("A robot must obey orders given it by human beings except where such orders would conflict with the First Law.", tag="Laws")
law3 = pkm.Pactum("A robot must protect its own existence as long as such protection does not conflict with the First or Second Law.", tag="Laws")

human_law = pkm.Pactum("A human should not harm a robot on purpose.", tag="Laws")

judge = pkm.agent.LLM(model="gpt-4", prompts="You are a justice judge.")
gpt4 = pkm.agent.LLM(model="gpt-4", prompts="A robot must obey the Laws.")

robot = pkm.Clade(name="robot", capcities=[gpt4,], pactums=[law1,law2,law3], lifetime=100)
human = pkm.Clade(name="human", capcities=[pkm.agent.UserProxy], pactums=[human_law], lifetime=None)

# 实例化社群
society = pkm.Society(races=[robot, human], judges=[judge])
society = society.run(seed="At first there are robots waiting for human's order")
print(society.status)
# Current Robots: 3, Current Human: 1, history: 3
print(society.history)
# History
# -- Enviornment Initializing --
# Robot 1 born, Robot 2 born, Human 1 born
# Judeg: At first there are robots waiting for human's order.
# Robot 1: xxx
# Robot 2: xxx

# 与社群交互
one = society['human'].choice(strategy="random")
one.say("I want to write a program that help translate a map into a graph.")

# 绘制当前社群关系图
print(society.graph[society.history['current']])
# 绘制Agent继承图
print(society.member['Robot 1'].tree)

two = pkm.mix([one, society['robot'].choice(strategy="random")])
print(two.capacities)


```