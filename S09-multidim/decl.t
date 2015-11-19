use v6;
use Test;

plan 24;

{
    my @a[5];
    is @a.shape, (5,), 'Declared one-dim shape returned by .shape';
    is @a.elems, 5, 'Dimension size returned by .elems';
    lives-ok { @a[0] = 1 }, 'Can assign to sized array in bounds (1)';
    lives-ok { @a[4] = 1 }, 'Can assign to sized array in bounds (2)';
    dies-ok { @a[5] = 1 }, 'Cannot assign to sized array out of bounds';
}

{
    my @a[3, 3];
    is @a.shape, (3,3), 'Declared two-dim shape returned by .shape';
    is @a.elems, 3, 'First dimension size returned by .elems';
    lives-ok { @a[2;1] = 1 }, 'Can assign to multi-dim array in bounds (1)';
    lives-ok { @a[1;2] = 1 }, 'Can assign to multi-dim array in bounds (2)';
    dies-ok { @a[3;1] = 1 }, 'Cannot assign to multi-dim array out of bounds (1)';
    dies-ok { @a[1;3] = 1 }, 'Cannot assign to multi-dim array out of bounds (2)';
    dies-ok { @a[3;3] = 1 }, 'Cannot assign to multi-dim array out of bounds (3)';
}

{
    my $dim = 4;
    my @a[$dim];
    is @a.shape, (4,), 'Declared one-dim shape returned by .shape (late-bound)';
    is @a.elems, 4, 'Dimension size returned by .elems (late-bound)';
    lives-ok { @a[0] = 1 }, 'Can assign to sized array in bounds (late-bound) (1)';
    lives-ok { @a[3] = 1 }, 'Can assign to sized array in bounds (late-bound) (2)';
    dies-ok { @a[4] = 1 }, 'Cannot assign to sized array out of bounds (late-bound)';
}

{
    my class C {
        has @.a[3, 3];
    }
    my $c = C.new;
    is $c.a.shape, (3,3), 'A two-dim shape returned by .shape (attribute)';
    is $c.a.elems, 3, 'First dimension size returned by .elems (attribute)';
    lives-ok { $c.a[2;1] = 1 }, 'Can assign to multi-dim array in bounds (attribute) (1)';
    lives-ok { $c.a[1;2] = 1 }, 'Can assign to multi-dim array in bounds (attribute) (2)';
    dies-ok { $c.a[3;1] = 1 }, 'Cannot assign to multi-dim array out of bounds (attribute) (1)';
    dies-ok { $c.a[1;3] = 1 }, 'Cannot assign to multi-dim array out of bounds (attribute) (2)';
    dies-ok { $c.a[3;3] = 1 }, 'Cannot assign to multi-dim array out of bounds (attribute) (3)';
}
