import { Module } from '@nestjs/common';
import { DbModule } from './db/db.module';
import { UsuarioModule } from './user/user.module';
import { SkillModule } from './skill/skill.module';

@Module({
  imports: [DbModule, UsuarioModule, SkillModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
