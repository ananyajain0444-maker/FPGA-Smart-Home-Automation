import os
import matplotlib.pyplot as plt

os.makedirs("images", exist_ok=True)

# =====================================================

# SMART HOME ARCHITECTURE

# =====================================================

fig, ax = plt.subplots(figsize=(12,8))
ax.set_xlim(0,100)
ax.set_ylim(0,100)
ax.axis("off")

# Blocks

ax.text(50,90,"Sensors\n(Motion, Temp,\nDoor, Switches)",
ha="center",va="center",
fontsize=14,
bbox=dict(boxstyle="round,pad=0.5"))

ax.text(50,70,"Smart Home Controller",
ha="center",va="center",
fontsize=14,
bbox=dict(boxstyle="round,pad=0.5"))

ax.text(25,45,"Control FSM",
ha="center",va="center",
fontsize=14,
bbox=dict(boxstyle="round,pad=0.5"))

ax.text(75,45,"Scene Controller",
ha="center",va="center",
fontsize=14,
bbox=dict(boxstyle="round,pad=0.5"))

ax.text(50,25,"PWM Generator",
ha="center",va="center",
fontsize=14,
bbox=dict(boxstyle="round,pad=0.5"))

ax.text(50,5,"Outputs\n(Light, Fan, Alarm)",
ha="center",va="center",
fontsize=14,
bbox=dict(boxstyle="round,pad=0.5"))

# Connector lines

ax.plot([50,50],[84,76],linewidth=2)
ax.plot([50,25],[64,50],linewidth=2)
ax.plot([50,75],[64,50],linewidth=2)
ax.plot([25,50],[40,30],linewidth=2)
ax.plot([75,50],[40,30],linewidth=2)
ax.plot([50,50],[19,10],linewidth=2)

plt.title("Smart Home FPGA Architecture",fontsize=20)
plt.savefig(
"images/smart_home_architecture.png",
dpi=300,
bbox_inches="tight"
)
plt.close()

# =====================================================

# FSM STATE DIAGRAM

# =====================================================

fig, ax = plt.subplots(figsize=(12,8))
ax.set_xlim(0,100)
ax.set_ylim(0,100)
ax.axis("off")

ax.text(
25,75,"IDLE",
fontsize=16,
ha="center",
bbox=dict(boxstyle="circle,pad=0.8")
)

ax.text(
75,75,"AUTO",
fontsize=16,
ha="center",
bbox=dict(boxstyle="circle,pad=0.8")
)

ax.text(
25,25,"MANUAL",
fontsize=16,
ha="center",
bbox=dict(boxstyle="circle,pad=0.8")
)

ax.text(
75,25,"ALARM",
fontsize=16,
ha="center",
bbox=dict(boxstyle="circle,pad=0.8")
)

# FSM connections

ax.plot([32,68],[75,75],linewidth=2)
ax.text(50,80,"Motion / Temperature",ha="center")

ax.plot([25,25],[68,32],linewidth=2)
ax.text(10,50,"Manual Override")

ax.plot([75,75],[68,32],linewidth=2)
ax.text(82,50,"Security + Door")

ax.plot([32,68],[25,25],linewidth=2)
ax.text(50,30,"Alarm Trigger",ha="center")

plt.title("Control FSM State Diagram",fontsize=20)
plt.savefig(
"images/fsm_state_diagram.png",
dpi=300,
bbox_inches="tight"
)
plt.close()

print("Generated:")
print("images/smart_home_architecture.png")
print("images/fsm_state_diagram.png")
