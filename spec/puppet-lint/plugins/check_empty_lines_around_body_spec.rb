# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
describe 'empty_lines_around_body' do
  ## if block
  context 'with fix disabled' do
    let(:msg) { 'empty line at start of if block' }

    ## neither leading nor trailing empty line
    context 'neither leading nor trailing empty line in if block' do
      let(:code) { "if $foo == 'bar' {\n  include role::foo\n}\n" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    ## leading empty line
    context 'empty line after opening curly of if block' do
      let(:code) { "if $foo == 'bar' {\n  \n  include role::foo\n}\n" }

      it 'should detect a single problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(2).in_column(3)
      end
    end
  end

  context 'with fix disabled' do
    let(:msg) { 'empty line at end of if block' }

    ## trailing empty line
    context 'empty line before closing curly of if block' do
      let(:code) { "if $foo == 'bar' {\n  include role::foo\n  \n}\n" }

      it 'should detect a single problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(3).in_column(3)
      end
    end
  end

  ## class block
  context 'with fix disabled' do
    let(:msg) { 'empty line at start of class block' }

    ## neither leading nor trailing empty line
    context 'neither leading nor trailing empty line in class block' do
      let(:code) { "class foo {\n  include role::bar\n}\n" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    ## leading empty line
    context 'empty line after opening curly of if block' do
      let(:code) { "class foo {\n  \n  include role::bar\n}\n" }

      it 'should detect a single problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(2).in_column(3)
      end
    end
  end

  context 'with fix disabled' do
    let(:msg) { 'empty line at end of class block' }

    ## trailing empty line
    context 'empty line before closing curly of class block' do
      let(:code) { "class foo {\n  include role::bar\n  \n}\n" }

      it 'should detect a single problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(3).in_column(3)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
