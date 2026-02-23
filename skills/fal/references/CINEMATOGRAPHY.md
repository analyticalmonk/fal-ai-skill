# Cinematography & Visual Storytelling Reference

Apply these techniques when crafting prompts for image and video generation.

## Core Principle

**One idea per clip.** For short videos (3-6s), commit to a single camera movement and one clear action. Combining multiple movements confuses models.

---

## Camera Movements

Use these terms in video prompts to direct motion:

| Movement | Prompt Language | Best For |
|----------|----------------|----------|
| **Pan** | "camera pans left to right" | Revealing a scene, following horizontal action |
| **Tilt** | "camera tilts up from ground to sky" | Revealing height, dramatic reveals |
| **Dolly in/out** | "camera slowly dollies in toward" | Building intimacy or tension |
| **Truck** | "camera trucks alongside" | Following a walking/moving subject |
| **Crane/Boom** | "camera cranes up revealing" | Establishing shots, dramatic scale |
| **Orbit/Arc** | "camera orbits around the subject" | Product shots, hero moments |
| **Push in** | "slow push in on the face" | Emotional emphasis |
| **Pull out** | "camera pulls back to reveal" | Context reveals, endings |
| **Static** | "locked-off static shot" | Dialogue, contemplative moments |

## Shot Types

| Shot | Prompt Language | Use Case |
|------|----------------|----------|
| **Extreme close-up** | "extreme close-up of hands" | Detail, emotion, texture |
| **Close-up** | "close-up portrait shot" | Faces, reactions, intimacy |
| **Medium** | "medium shot from waist up" | Conversation, action |
| **Wide** | "wide establishing shot" | Setting, context, scale |
| **Extreme wide** | "vast aerial panorama" | Landscapes, epic scale |
| **POV** | "first-person POV walking through" | Immersion, exploration |
| **Over-the-shoulder** | "over-the-shoulder looking at" | Dialogue, perspective |

## Camera Angles

| Angle | Effect |
|-------|--------|
| **Eye level** | Neutral, natural |
| **Low angle** | Power, dominance, heroism |
| **High angle** | Vulnerability, overview |
| **Dutch angle** | Unease, tension, stylization |
| **Bird's eye** | Abstract patterns, god-view |
| **Worm's eye** | Extreme drama, towering subjects |

## Camera Style

| Style | Prompt Language | Feel |
|-------|----------------|------|
| **Handheld** | "handheld shaky camera" | Raw, documentary, UGC, authentic |
| **Steadicam** | "smooth steadicam follow" | Cinematic, polished tracking |
| **Gimbal** | "stabilized gimbal shot" | Modern, clean movement |
| **Drone** | "aerial drone shot" | Sweeping, establishing |
| **Tripod** | "tripod-mounted static" | Stable, professional |

---

## Image Composition

Apply to both image and video prompts:

- **Rule of thirds** - "subject positioned off-center, rule of thirds"
- **Leading lines** - "converging lines drawing eye toward subject"
- **Depth of field** - "shallow depth of field, soft bokeh background"
- **Framing** - "framed through a doorway/window/arch"
- **Symmetry** - "perfectly symmetrical composition"
- **Negative space** - "minimal composition with negative space"

---

## Lighting

| Lighting | Prompt Language | Mood |
|----------|----------------|------|
| **Golden hour** | "warm golden hour sunlight" | Warm, romantic, nostalgic |
| **Blue hour** | "cool blue hour twilight" | Moody, contemplative |
| **High key** | "bright high-key lighting" | Clean, optimistic, commercial |
| **Low key** | "dramatic low-key lighting, deep shadows" | Noir, tension, mystery |
| **Backlit** | "backlit silhouette" | Drama, ethereal |
| **Rembrandt** | "Rembrandt lighting, triangle on cheek" | Portraiture, classic |
| **Neon** | "neon-lit, cyberpunk glow" | Urban, futuristic |
| **Natural** | "soft natural window light" | Authentic, casual |

---

## Storytelling Tips

1. **Start with the subject** - clearly describe who/what is in frame before describing action
2. **Specify one action** - "picks up the mug and smiles" not "picks up the mug, drinks, puts it down, stands up, walks away"
3. **Set the mood with lighting** - lighting communicates emotion more than words
4. **Match camera to content:**
   - Product showcase → orbit/dolly, clean lighting
   - UGC/testimonial → handheld, natural light
   - Cinematic → steadicam, dramatic lighting
   - Epic/landscape → drone/crane, golden hour
5. **Describe the ending state** for short clips - models handle clear start-to-end arcs better
6. **Include texture and material cues** - "ceramic mug", "worn leather jacket", "polished marble" add realism

---

## Prompt Structure Template

```
[Shot type + camera angle], [subject description], [action], [camera movement], [lighting/mood], [style keywords]
```

**Example:**
> Close-up low angle, a barista pouring steamed milk into a latte, camera slowly pushes in, warm morning window light, shallow depth of field, cinematic 24fps
