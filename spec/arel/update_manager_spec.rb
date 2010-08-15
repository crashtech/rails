require 'spec_helper'

module Arel
  describe 'update manager' do
    describe 'new' do
      it 'takes an engine' do
        Arel::UpdateManager.new Table.engine
      end
    end

    describe 'table' do
      it 'generates an update statement' do
        um = Arel::UpdateManager.new Table.engine
        um.table Table.new(:users)
        um.to_sql.should be_like %{ UPDATE "users" }
      end

      it 'chains' do
        um = Arel::UpdateManager.new Table.engine
        um.table(Table.new(:users)).should == um
      end
    end

    describe 'where' do
      it 'generates a where clause' do
        table = Table.new :users
        um = Arel::UpdateManager.new Table.engine
        um.table table
        um.where table[:id].eq(1)
        um.to_sql.should be_like %{
          UPDATE "users" WHERE "users"."id" = 1
        }
      end

      it 'chains' do
        table = Table.new :users
        um = Arel::UpdateManager.new Table.engine
        um.table table
        um.where(table[:id].eq(1)).should == um
      end
    end
  end
end
