
module.exports =
	class Grid
		constructor: (@width, @height) ->
			@internal =
				next:
					x: 0
					y: 0

		cellEmpty: (cell) ->
			if @internal["" + cell.x + "," + cell.y]?
				return false
			else return true

		checkFit: (cell) ->
			count = 0
			for i in [0..cell.size]
				cell =
					x: cell.x + (cell.isHorizontal ? i : 0)
					y: cell.y + (cell.isHorizontal ? 0 : i)
				if this.cellEmpty cell
					count++
				else break
			if count is cell.size
				return true
			else return false

		markCells: (cell) ->
			for i in [0..cell.size]
				cell =
					x: cell.x + (cell.isHorizontal ? i : 0)
					y: cell.y + (cell.isHorizontal ? 0 : i)
				@internal["" + cell.x + "," + cell.y] = true

		fit: (image) ->
			ratio = image.width / image.height
			isHor = ratio >= 1.0
			ratio = ratio >= 1.0 ? ratio : 1.0 / ratio
			ratioInt = Math.round ratio

			done = false
			curr = @internal.next

			while not done
				cell =
					x: curr.x
					y: curr.y
					isHorizontal: isHor
					size: ratioInt
				if checkFit cell
					done = true
					markCells cell
				else curr++
