﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostEffectScript : MonoBehaviour {

	public Material material;

	void OnRenderImage(RenderTexture src, RenderTexture dest){
		
		Graphics.Blit(src,dest, material);
	}
}
