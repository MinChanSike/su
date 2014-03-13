su
==

DIY Sass grid engine.
We use this engine for [Susy][Susy],
but you can use it to build any grid system you want.

Make up your own,
or port existing tools like
[oocss][oocss], [singularity][singularity],
[zurb][zurb], [neat][neat], [zen][zen],
[blueprint][blueprint], [960gs][960gs], etc.

[Susy]:http://susy.oddbird.net
[oocss]: http://oocss.org/
[singularity]: http://singularity.gs/
[zurb]: http://foundation.zurb.com/
[neat]: http://neat.bourbon.io/
[zen]: http://zengrids.com/
[blueprint]: http://www.blueprintcss.org/
[960gs]: http://960.gs/


Settings
--------

Su has only two settings:
`columns` (a number or list of numbers), and
`gutters` (a number).

```scss
$symmetrical: (
  columns: 12,
  gutters: 1/4,
);

$asymmetrical: (
  columns: (1 3 4 6 2),
  gutters: .5,
);
```

Both `columns` and `gutters` are set
as unitless numbers,
but you can think of them as "grid units" —
as they are all relative to each other.
`1/4` gutter is a quarter the size of `1` column.


Susy Count
----------

Find the number of columns in a given layout.

- `$columns`: `<number>` | `<list>`

This is only necessary for asymetrical grids,
since symmetrical are already defined by their count,
but the function handles both styles
for the sake of flexibility.

`<number>`:
Susy grid layouts are defined by columns.
In a symmetrical grid
all the columns are the same relative width,
so they can be defined by the number of columns.
We can have an "8-column" grid, or a "12-column" grid.

```scss
// input
$count: susy-count(12);

// output
$count: 12;
```

`<list>`:
Asymmetrical grids are more complex.
Since each column can have a different width
relative to the other columns,
we need to provide more detail about the columns.
We can do that with a list of relative (unitless sizes).
Each number in the list
represents a number of grid units
relative to the other numbers.

```scss
// input
$count: susy-count(1 2 4 3 1);

// output
$count: 5;
```

For asymmetrical grids,
the number of columns is egual to the list length.
This isn't complex math.


Susy Sum
--------

Find the total sum of column-units in a layout.

- `$columns`: `<number>` | `<list>`
- `$gutters`: `<ratio>`
- `$spread`: `false`/`narrow` | `wide` | `wider`

Rather than counting how many columns there are,
the `susy-sum` function calculates
the total number of grid units covered.
It's a simple matter of adding together all the columns
as well as the gutters between them.

```scss
// input
$susy-sum: susy-sum(7, .5);

// output: 7 + (6 * .5) = 10
$susy-sum: 10;
```

Most grids have one less gutter than column,
but that's not always true.
The `spread` argument allows you to also include
the gutters on either side.
While the default `narrow` spread subtracts a gutter,
the `wide` spread
(common when using split gutters)
has an equal number of columns and gutters.

```scss
// input
$wide-sum: susy-sum(7, .5, wide);

// output: 7 + (7 * .5) = 10.5
$wide-sum: 10.5;
```

On rare occasions
you may actually want gutters on both sides,
which we call a `wider` spread.

```scss
// input
$wider-sum: susy-sum(7, .5, wider);

// output: 7 + (8 * .5) = 11
$wider-sum: 11;
```

This is all possible with asymmetrical grids as well.

```scss
// input
$susy-sum: susy-sum(1 2 4 2, 1/3);

// output: (1 + 2 + 4 + 2) + (3 * 1/3) = 10
$susy-sum: 10;
```


Susy Slice
----------

Return a subset of columns at a given location.

- `$span`: `<number>`
- `$location`: `<number>`
- `$columns`: `<number>` | `<list>`

This is only necessary for asymmetrical grids,
since a symmetrical subset is always equal to the span,
but the function handles both styles
for the sake of flexibility.

The `location` is given
as a column index, starting with 1,
so that `1` is the first column,
`2` is the second, and so on.

```scss
// input
$sym-slice: susy-slice(3, 2, 7);
$asym-slice: susy-slice(3, 2, (1 2 3 5 4));

// output: 3 columns, starting with the second
$sym-slice: 3;
$asym-slice: (2 3 5);
```

Susy
----

Find the sum of a column-span.

- `$span`: `<number>`
- `$location`: `<number>`
- `$columns`: `<number>` | `<list>`
- `$gutters`: `<ratio>`
- `$spread`: `false`/`narrow` | `wide` | `wider`

This is where it all comes together.
`susy` is the base version of
:ref:`span <tools-span-function>` —
the core building-block for any grid system.
It combines `susy-span` with `susy-sum`
to return the (still unitless) width of a given span.

```scss
// input
$sym-span: susy(3, 2, 7, .5);
$asym-span: susy(3, 2, (1 2 3 5 4), .5);

// output
$sym-span: 4;
$asym-span: 11;
```


Is Symmetrical
--------------

Returns `null` if a grid is asymmetrical.

- `$columns`: `<number>` | `<list>`

It's not a difficult test,
but it's important to know what you're dealing with.

```scss
// input
$sym: is-symmetrical(12);
$asym: is-symmetrical(2 4 6 3);

// output
$sym: 12;
$asym: null;
```


Build Something New
-------------------

That's really all it takes to build a grid system.
The rest is just syntax.
Start with `susy`.

```scss
$sum: susy(3, 2, 7);

If you want static grids,
you can multiply the results
by the width of one column.

```scss
// static
$column-width: 4em;
$static: $sum * $column-width;
```

For a fluid grid,
divide the results by the context span sum,
to get a percentage.

```scss
// fluid
$context: susy(7);
$fluid: percentage($sum / $context);
```

That's all it takes.
Now go build yourself a grid system!
