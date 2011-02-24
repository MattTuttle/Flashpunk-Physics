package com.matttuttle
{
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	public class GameWorld extends World
	{
		
		public function GameWorld()
		{
			FP.screen.color = 0x8EDFFA;
			
			add(new Character(FP.screen.width / 2, FP.screen.height - 64));
			
			// Create tilemap
			var tilemap:Tilemap = new Tilemap(Assets.GfxBlock, FP.screen.width / 32, FP.screen.height / 32, 32, 32);
			// Create grid mask
			var grid:Grid = new Grid(tilemap.columns, tilemap.rows, tilemap.tileWidth, tilemap.tileHeight);
			
			// Fill the tilemap and grid programatically
			var i:int;
			for (i = 0; i < tilemap.columns; i++)
			{
				// top wall
				tilemap.setTile(i, 0, 1);
				grid.setTile(i, 0, true);
				// bottom wall
				tilemap.setTile(i, tilemap.rows - 1, 1);
				grid.setTile(i, tilemap.rows - 1, true);
			}
			for (i = 0; i < tilemap.rows; i++)
			{
				// left wall
				tilemap.setTile(0, i, 1);
				grid.setTile(0, i, true);
				// right wall
				tilemap.setTile(tilemap.columns - 1, i, 1);
				grid.setTile(tilemap.columns - 1, i, true);
			}
			
			// Create a new entity to use as a tilemap
			var entity:Entity = new Entity();
			entity.graphic = tilemap;
			entity.mask = grid;
			entity.type = "solid";
			add(entity);
		}
		
	}

}