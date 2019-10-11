use 5.010001;
use Test2::V0;
use Test2::Tools::Spec;
use Types::Standard qw( Int );
use Types::TypedCodeRef::Factory;

describe 'Use default name generator' => sub {

  my $factory = Types::TypedCodeRef::Factory->new(sub_meta_finders => []);

  describe 'Sequenced parameters' => sub {

    it 'One parameter' => sub {
      is(
        $factory->name_generator->($factory->name, [Int] => Int),
        $factory->name . '[ [Int] => Int ]'
      );
    };

    it 'Multiple parameters' => sub {
      is(
        $factory->name_generator->($factory->name, [Int, Int, Int] => Int),
        $factory->name . '[ [Int, Int, Int] => Int ]'
      );
    };

  };

  describe 'Named parameters' => sub {
    
    it 'One parameter' => sub {
      is(
        $factory->name_generator->($factory->name, +{ a => Int } => Int),
        $factory->name . '[ { a => Int } => Int ]'
      );
    };
    
    it 'Multiple parameters' => sub {
      is(
        $factory->name_generator->($factory->name, +{ b => Int, a => Int, c => Int } => Int),
        $factory->name . '[ { a => Int, b => Int, c => Int } => Int ]'
      );
    };

  };

  describe 'Use instance of Sub::Meta directly' => sub {

    it q{Name generator returns instance's address} => sub {
      my $meta = Sub::Meta->new(
        parameters => Sub::Meta::Parameters->new(
          args   => [],
          slurpy => 1,
        ),
        returns => Sub::Meta::Returns->new(),
      );
      is $factory->name_generator->($factory->name, $meta), $factory->name . "[$meta]";
    };

  };
  
};

done_testing;
